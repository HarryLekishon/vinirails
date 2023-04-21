puts("Seeding")





User.create!([
  {
    name: "Alex",
    username: "alexkimathi",
    email: "admin@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    "admin": true 
  },
  {
    name: "Mabel",
    username: "mabelkimani",
    email: "mabel@gmail.com",
    password: "123456",
    password_confirmation: "123456" 
  }

 
])



puts("Done seeding")