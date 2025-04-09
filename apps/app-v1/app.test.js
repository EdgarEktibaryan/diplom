const request = require('supertest');
const app = require('./app');

describe('GET /', () => {
  it('should return HTML with Version 1 in it', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toContain('Version 1');
    expect(res.headers['content-type']).toMatch(/html/);
  });
});