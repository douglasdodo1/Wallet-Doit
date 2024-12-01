// prisma-client.js
import { PrismaClient } from '@prisma/client';

// Verifica se a instância já foi criada e armazenada em cache
let prisma;

if (process.env.NODE_ENV === 'production') {
  // Em produção, usa uma instância única do PrismaClient
  if (!global.prisma) {
    global.prisma = new PrismaClient();
  }
  prisma = global.prisma;
} else {
  // Em desenvolvimento, cria uma nova instância a cada vez para facilitar a depuração
  if (!prisma) {
    prisma = new PrismaClient();
  }
}

export default prisma; 

