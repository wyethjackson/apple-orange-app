// gateway/server.js
const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 80;

const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:4000';
const FRONTEND_URL = process.env.FRONTEND_URL || 'http://localhost:3000';

// Proxy API to backend
app.use('/api', createProxyMiddleware({
    target: BACKEND_URL,
    changeOrigin: true,
}));

// Proxy frontend (Next.js app)
app.use('/', createProxyMiddleware({
    target: FRONTEND_URL,
    changeOrigin: true,
}));

app.listen(PORT, () => {
    console.log(`Gateway listening on port ${PORT}`);
    console.log(`Proxying API requests to ${BACKEND_URL}`);
    console.log(`Proxying frontend requests to ${FRONTEND_URL}`);
});
