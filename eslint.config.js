// eslint.config.js
import js from '@eslint/js';

export default [
  js.configs.recommended,

  {
    ignores: ['node_modules/', 'output/', 'input/', 'package-lock.json'],
  },
  {
    files: ['server.cjs'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'commonjs', // or 'script' 
      globals: {
        require: 'readonly',
        __dirname: 'readonly',
        console: 'readonly',
        process: 'readonly',
      },
    },
  },
  {
    files: ['public/**/*.js'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'script',
      globals: {
        document: 'readonly',
        alert: 'readonly',
        fetch: 'readonly',
        window: 'readonly',
      },
    },
  },
];
