namespace :control do
  desc "Creates 1k users"
  task :create_users => :environment do
    (1..1000).each do |i|
      User.create(:name => "user#{i}", :password => "password", :password_confirmation => "password")
    end
  end


  # rake control:vote[id, upvotes, downvates]
  desc "Up vote and downvote"
  task :vote=> :environment do |t, args|
    card_id, upvotes_count, downvotes_count = *args.values
    if upvotes_count + downvotes_count <= 1000

      (1..upvotes_count).each do |i|
        user = User.find_by_name "user#{i}"
        vote = Vote.find_by_user_id_and_story_card_id user.id, card_id
        params = {:user_id => user.id, :story_card_id => card_id, :value => 1}
        unless vote
          Vote.create(params)
        else
          vote.update_attributes(params)
        end

      end

      if downvotes_count
        (upvotes_count..(upvotes_count+downvotes_count)).each do |i|
          user = User.find_by_name "user#{i}"
          vote = Vote.find_by_user_id_and_story_card_id user.id, card_id
          params = {:user_id => user.id, :story_card_id => card_id, :value => -1}
          unless vote
            Vote.create(params)
          else
            vote.update_attributes(params)
          end
        end
      end

    end
  end
end