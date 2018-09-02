namespace :dev do
  task fake_member: :environment do
    20.times do |i|
     name = "member#{i+1}"
      member = Member.new(
        name: name,
        email: "#{name}@example.com",
        password: "111111"
        )
      member.save
      puts member.name
      
    end
  end
end