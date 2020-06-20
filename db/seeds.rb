# テストユーザー
User.create!(nick_name: "KPT太郎", email: "kpt@kpt", password: "kptaaalk")

50.times do |i|

  user = User.create!(
    nick_name: "TEST-#{i}",
    email: "kpt@#{i}",
    password: "password",
    introduction: "テストユーザーです。"
  )

  group = Group.create!(
    name: "TEST-GROUP-#{i}"
  )

  if i % 3 == 0
    is_confirmed = true
  else
    is_confirmed = false
  end

  GroupUser.create!(
    user_id: user.id,
    group_id: group.id,
    is_confirmed: is_confirmed
  )

  if i % 3 == 0
    place_status = 0
  elsif i % 5 == 0
    place_status = 1
  else
    place_status = 2
  end

  Comment.create!(
    user_id: user.id,
    group_id: group.id,
    comment: "テストコメント#{i}",
    place_status: place_status
  )

end
