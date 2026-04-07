import bcrypt from 'bcryptjs';

const hash = await bcrypt.hash('password123', 10);
console.log('Hash:', hash);
console.log('Salt:', hash.slice(0, 29));