const { PrismaClient } = require('./generated/client');

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Seeding database...');

  // Create amenities
  const amenities = [
    { name: 'Wi-Fi', icon: 'wifi', category: 'tech' },
    { name: 'Air Conditioning', icon: 'snowflake', category: 'comfort' },
    { name: 'Kitchen', icon: 'utensils', category: 'kitchen' },
    { name: 'Parking', icon: 'car', category: 'transport' },
    { name: 'Projector', icon: 'tv', category: 'tech' },
    { name: 'Sound System', icon: 'music', category: 'tech' },
    { name: 'Outdoor Space', icon: 'tree', category: 'outdoor' },
    { name: 'Bar', icon: 'wine', category: 'kitchen' },
    { name: 'Restrooms', icon: 'bathroom', category: 'basic' },
    { name: 'Accessibility', icon: 'wheelchair', category: 'basic' },
    { name: 'Security', icon: 'shield', category: 'safety' },
    { name: 'Catering', icon: 'chef-hat', category: 'kitchen' },
    { name: 'Tables & Chairs', icon: 'chair', category: 'furniture' },
    { name: 'Lighting', icon: 'lightbulb', category: 'comfort' },
    { name: 'Heating', icon: 'thermometer', category: 'comfort' },
    { name: 'Storage', icon: 'box', category: 'basic' },
    { name: 'Cleaning Service', icon: 'sparkles', category: 'service' },
    { name: 'Staff Support', icon: 'users', category: 'service' },
    { name: 'Audio/Video Equipment', icon: 'video', category: 'tech' },
    { name: 'Dance Floor', icon: 'music-note', category: 'entertainment' }
  ];

  for (const amenity of amenities) {
    await prisma.amenity.upsert({
      where: { name: amenity.name },
      update: {},
      create: amenity,
    });
  }

  console.log('✅ Amenities seeded successfully');
  console.log('🎉 Database seeding completed!');
}

main()
  .catch((e) => {
    console.error('❌ Seeding failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  }); 