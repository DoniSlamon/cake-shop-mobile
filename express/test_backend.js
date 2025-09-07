// 🍰 Sweet Dreams Bakery - Backend Testing Script
// Run this to test backend endpoints quickly

const axios = require('axios');

const BASE_URL = 'http://localhost:3000';

async function testLogin() {
  try {
    console.log('🔐 Testing Login...');
    const response = await axios.post(`${BASE_URL}/users/login`, {
      username: 'customer1',
      password: 'password123'
    });
    
    console.log('✅ Login Success:', response.data);
    return response.data;
  } catch (error) {
    console.log('❌ Login Failed:', error.response?.data || error.message);
    return null;
  }
}

async function testRegister() {
  try {
    console.log('📝 Testing Registration...');
    const randomUsername = `testuser_${Date.now()}`;
    const response = await axios.post(`${BASE_URL}/users/register`, {
      username: randomUsername,
      email: `${randomUsername}@test.com`,
      full_name: 'Test User Name',
      phone: '+62-812-9999-8888',
      password: 'password123'
    });
    
    console.log('✅ Registration Success:', response.data);
    return response.data;
  } catch (error) {
    console.log('❌ Registration Failed:', error.response?.data || error.message);
    return null;
  }
}

async function testCakes() {
  try {
    console.log('🍰 Testing Get Cakes...');
    const response = await axios.get(`${BASE_URL}/cake`);
    console.log(`✅ Found ${response.data.length} cakes`);
    return response.data;
  } catch (error) {
    console.log('❌ Get Cakes Failed:', error.response?.data || error.message);
    return null;
  }
}

async function runTests() {
  console.log('🚀 Starting Sweet Dreams Bakery Backend Tests...\n');
  
  const loginResult = await testLogin();
  console.log('');
  
  const registerResult = await testRegister();
  console.log('');
  
  const cakesResult = await testCakes();
  console.log('');
  
  console.log('🏁 Testing completed!');
  
  if (loginResult && cakesResult) {
    console.log('✅ Backend is working properly! 🍰');
  } else {
    console.log('❌ Some tests failed. Check server logs.');
  }
}

// Run tests
runTests().catch(console.error);
