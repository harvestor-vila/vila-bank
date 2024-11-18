// next.config.js
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  images: {
    unoptimized: true,
  },
  basePath: '/vila-bank', // Replace with your GitHub repository name
  assetPrefix: '/vila-bank/', // Same as above
};

module.exports = nextConfig;
