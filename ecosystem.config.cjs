module.exports = {
  apps: [
    {
      name: 'lottery-backend',
      script: 'server.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '1G',
      env: {
        NODE_ENV: 'production',
        PORT: 5001,
      },
    },
    {
      name: 'lottery-frontend',
      script: 'frontend-server.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '500M',
      env: {
        NODE_ENV: 'production',
        FRONTEND_PORT: 3005,
      },
    },
  ],
};
