namespace :dev do
  task fake_member: :environment do

    10.times do |i|
     name = "member #{i+1}"
      member = Member.new(
        name: name,
        email: "#{name}@example.com",
        password: "111111"
        )
      member.save
      puts member.name
      
    end
  end

  task fake_plan: :environment do
    5.times do |i|
      member = Member.all.sample
      Plan.create!(
        title: "plan#{i+1}",
        member: member 
        )
    end
    puts "create #{Plan.count} fake plan"
  end
end