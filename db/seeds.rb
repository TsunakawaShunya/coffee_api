# Users
user = User.create!(
  provider: 'email',
  uid: 'test@mail.com',
  email: 'test@mail.com',
  password: 'testtest',
  password_confirmation: 'testtest',
  name: 'test',
  nickname: 'test'
)

# Beans
beans = [
  { name: 'コスタリカ/イエローハニー', roast: 'ミディアムロースト', process: 'ハニープロセス' },
  { name: 'エチオピア/イルガチェフェ', roast: 'ライトロースト', process: 'ウォッシュド' },
  { name: 'グアテマラ/アンティグア', roast: 'ミディアムロースト', process: 'ウォッシュド' },
  { name: 'コロンビア/ナリーニョ', roast: 'ダークロースト', process: 'ウォッシュド' },
  { name: 'ケニア/キアンブ', roast: 'ミディアムロースト', process: 'ウォッシュド' },
  { name: 'パナマ/ゲイシャ', roast: 'ライトロースト', process: 'ナチュラル' },
  { name: 'ブラジル/サントス', roast: 'ミディアムロースト', process: 'ナチュラル' },
  { name: 'インドネシア/マンデリン', roast: 'ダークロースト', process: 'スマトラ式' },
  { name: 'ホンジュラス/マルカラ', roast: 'ミディアムロースト', process: 'ハニープロセス' },
  { name: 'ペルー/チャチャポヤス', roast: 'ライトロースト', process: 'ウォッシュド' }
]

bean_records = beans.map do |bean|
  Bean.create!(user: user, **bean)
end

# Recipes
recipes = [
  { title: 'フレンチプレス', method: 'フレンチプレス', temp: 93, ratio: 7.0, comment: 'しっかりとしたボディ感' },
  { title: 'エスプレッソ', method: 'エスプレッソ', temp: 94, ratio: 2.0, comment: '濃厚で深い味わい' },
  { title: 'ペーパードリップ', method: 'ペーパードリップ', temp: 90, ratio: 6.0, comment: 'すっきりとした味わい' },
  { title: 'エアロプレス', method: 'エアロプレス', temp: 85, ratio: 5.0, comment: 'バランスの取れた風味' },
  { title: 'ネルドリップ', method: 'ネルドリップ', temp: 88, ratio: 6.5, comment: 'まろやかでコクのある味' }
]

recipe_records = recipes.map do |recipe|
  Recipe.create!(user: user, **recipe)
end

# Notes
notes = [
  { bean: bean_records[0], recipe: recipe_records[2], taste_x: 0.4, taste_y: -1.5, comment: 'フルーティで甘みがある' },
  { bean: bean_records[1], recipe: recipe_records[0], taste_x: 0.2, taste_y: 0.3, comment: '香りが良くて爽やか' },
  { bean: bean_records[2], recipe: recipe_records[1], taste_x: -0.3, taste_y: -1.0, comment: 'コクがありチョコレートのよう' },
  { bean: bean_records[3], recipe: recipe_records[3], taste_x: 0.5, taste_y: 0.2, comment: 'クリーミーでナッツの風味' },
  { bean: bean_records[4], recipe: recipe_records[4], taste_x: -0.1, taste_y: 0.5, comment: '酸味がありまろやか' }
]

notes.each do |note|
  Note.create!(**note)
end

puts 'Seeding completed!'