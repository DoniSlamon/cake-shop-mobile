var express = require("express");
var router = express.Router();
var db = require("./../database/db");

// Sweet Dreams Bakery - Review Management

function createReview(user_id, cake_id, comment, rating) {
    return new Promise((resolve, reject) => {
        // Validate rating
        if (!rating || rating < 1 || rating > 5) {
            return reject("Rating must be between 1 and 5");
        }

        db.query(
            "INSERT INTO reviews (user_id, cake_id, comment, rating) VALUES (?, ?, ?, ?)",
            [user_id, cake_id, comment, rating],
            (err, results) => {
                if (err) {
                    console.error("Database Error: ", err);
                    reject(err);
                } else {
                    console.log(`✅ Review created for cake ${cake_id} by user ${user_id}`);
                    resolve(results);
                }
            }
        );
    });
}

function getReviewsByCakeId(cake_id) {
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT r.*, u.username, u.full_name 
             FROM reviews r 
             JOIN users u ON r.user_id = u.id 
             WHERE r.cake_id = ? 
             ORDER BY r.created_at DESC`,
            [cake_id],
            (err, results) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(results);
                }
            }
        );
    });
}

function getReviewsByUserId(user_id) {
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT r.*, c.name as cake_name 
             FROM reviews r 
             JOIN cakes c ON r.cake_id = c.id 
             WHERE r.user_id = ? 
             ORDER BY r.created_at DESC`,
            [user_id],
            (err, results) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(results);
                }
            }
        );
    });
}

function updateReview(review_id, comment, rating, user_id) {
    return new Promise((resolve, reject) => {
        // Validate rating
        if (rating && (rating < 1 || rating > 5)) {
            return reject("Rating must be between 1 and 5");
        }

        // Check if user owns the review
        db.query(
            "SELECT user_id FROM reviews WHERE id = ?",
            [review_id],
            (err, results) => {
                if (err) {
                    reject(err);
                } else if (results.length === 0) {
                    reject("Review not found");
                } else if (results[0].user_id !== user_id) {
                    reject("Unauthorized to update this review");
                } else {
                    // Update review
                    const updateQuery = rating ? 
                        "UPDATE reviews SET comment = ?, rating = ?, updated_at = NOW() WHERE id = ?" :
                        "UPDATE reviews SET comment = ?, updated_at = NOW() WHERE id = ?";
                    const params = rating ? [comment, rating, review_id] : [comment, review_id];

                    db.query(updateQuery, params, (err, results) => {
                        if (err) {
                            reject(err);
                        } else {
                            resolve(results);
                        }
                    });
                }
            }
        );
    });
}

function deleteReview(review_id, user_id) {
    return new Promise((resolve, reject) => {
        // Check if user owns the review
        db.query(
            "SELECT user_id FROM reviews WHERE id = ?",
            [review_id],
            (err, results) => {
                if (err) {
                    reject(err);
                } else if (results.length === 0) {
                    reject("Review not found");
                } else if (results[0].user_id !== user_id) {
                    reject("Unauthorized to delete this review");
                } else {
                    // Delete review
                    db.query(
                        "DELETE FROM reviews WHERE id = ?",
                        [review_id],
                        (err, results) => {
                            if (err) {
                                reject(err);
                            } else {
                                resolve(results);
                            }
                        }
                    );
                }
            }
        );
    });
}

// Routes

// Get reviews for a specific cake
router.get("/cake/:cake_id", function (req, res) {
    getReviewsByCakeId(req.params.cake_id).then(
        (result) => {
            res.status(200).json(result);
        },
        (error) => {
            console.error("Error fetching reviews:", error);
            res.status(500).json({ error: error });
        }
    );
});

// Get reviews by a specific user
router.get("/user/:user_id", function (req, res) {
    getReviewsByUserId(req.params.user_id).then(
        (result) => {
            res.status(200).json(result);
        },
        (error) => {
            console.error("Error fetching user reviews:", error);
            res.status(500).json({ error: error });
        }
    );
});

// Legacy route for compatibility (get reviews by cake id)
router.get("/get/:id", function (req, res) {
    getReviewsByCakeId(req.params.id).then(
        (result) => {
            res.status(200).json(result);
        },
        (error) => {
            console.error("Error fetching reviews:", error);
            res.status(500).json({ error: error });
        }
    );
});

// Create new review
router.post("/create", function (req, res) {
    const body = req.body;
    console.log('🍰 Creating review:', body);

    createReview(body.user_id, body.cake_id, body.comment, body.rating).then(
        (result) => {
            res.status(200).json({ 
                message: "Review created successfully! Thank you for your feedback! 🍰",
                review_id: result.insertId 
            });
        },
        (error) => {
            console.error("Error creating review:", error);
            res.status(400).json({ error: error });
        }
    );
});

// Update review
router.put("/update/:id", function (req, res) {
    const body = req.body;
    const review_id = req.params.id;

    updateReview(review_id, body.comment, body.rating, body.user_id).then(
        (result) => {
            res.status(200).json({ message: "Review updated successfully! 🍰" });
        },
        (error) => {
            console.error("Error updating review:", error);
            res.status(400).json({ error: error });
        }
    );
});

// Delete review
router.delete("/delete/:id", function (req, res) {
    const review_id = req.params.id;
    const user_id = req.body.user_id || req.query.user_id;

    deleteReview(review_id, user_id).then(
        (result) => {
            res.status(200).json({ message: "Review deleted successfully! 🍰" });
        },
        (error) => {
            console.error("Error deleting review:", error);
            res.status(400).json({ error: error });
        }
    );
});

// Legacy routes for compatibility
router.post("/delete", function (req, res) {
    const body = req.body;
    deleteReview(body.id, body.user_id).then(
        (result) => {
            res.status(200).json(result);
        },
        (error) => {
            console.error("Error deleting review:", error);
            res.status(500).json({ error: error });
        }
    );
});

router.post("/update", function (req, res) {
    const body = req.body;
    updateReview(body.id, body.comment, body.rating, body.user_id).then(
        (result) => {
            res.status(200).json(result);
        },
        (error) => {
            console.error("Error updating review:", error);
            res.status(500).json({ error: error });
        }
    );
});

module.exports = router;