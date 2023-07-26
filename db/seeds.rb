# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create( email: '111111@example.com', name: 'Admim1', password: '111111')

Department.create([{name: "総務部"},{name: "管理部"},{name: "営業部"},{name: "法務部"},{name: "経理部"}])

Tag.create([{name: "文房具"},{name: "工具"},{name: "OA機器"},{name: "什器"},{name: "食材"},{name: "消耗品"},{name: "オフィス家具"}])