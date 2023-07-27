# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create( email: '111111@example.com', name: 'Admim1', password: '111111')

Department.create([{name: "総務部"},{name: "管理部"},{name: "営業部"},{name: "法務部"},{name: "経理部"}])

Tag.create([{name: "文房具"},{name: "工具"},{name: "OA機器"},{name: "什器"},{name: "食材"},{name: "消耗品"},{name: "オフィス家具"},{name: "その他"}])

User.create([ {name: '総務部部長', employee_number: '000001', department_id: '1', password: '111111'},
              {name: '総務部社員', employee_number: '000002', department_id: '1', password: '111111'},
              {name: '管理部部長', employee_number: '000003', department_id: '2', password: '111111'},
              {name: '管理部社員', employee_number: '000004', department_id: '2', password: '111111'},
              {name: '営業部部長', employee_number: '000005', department_id: '3', password: '111111'},
              {name: '営業部社員', employee_number: '000006', department_id: '3', password: '111111'},
              {name: '法務部部長', employee_number: '000007', department_id: '4', password: '111111'},
              {name: '法務部社員', employee_number: '000008', department_id: '4', password: '111111'},
              {name: '経理部部長', employee_number: '000009', department_id: '5', password: '111111'},
              {name: '経理部社員', employee_number: '000010', department_id: '5', password: '111111'}
            ])