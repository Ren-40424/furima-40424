# テーブル設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | text   | null: false |
| last_name          | text   | null: false |
| read_first_name    | text   | null: false |
| read_last_name     | text   | null: false |
| birth              | date   | null: false |

### Association

- has_many :items
- has_many :orders



## itemsテーブル

| Column            | Type      | Options     |
| ----------------- | --------- | ----------- |
| user              | reference | null: false, foreign_key: true |
| name              | string    | null: false |
| explanation       | text      | null: false |
| price             | integer   | null: false |
| category_id       | integer   | null: false |
| condition _id     | integer   | null: false |
| shipping_payer_id | integer   | null: false |
| prefecture_id     | integer   | null: false |
| shipping_days_id  | integer   | null: false |

### Association

- belongs_to :user
- has_one :order



## ordersテーブル

| Column      | Type      | Options     |
| ----------- | --------- | ----------- |
| item        | reference | null: false, foreign_key: true |
| user        | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination



## destinationsテーブル

| Column        | Type      | Options     |
| ------------- | --------- | ----------- |
| order         | reference | null: false, foreign_key: true |
| postal_code   | string    | null: false |
| prefecture_id | integer   | null: false |
| city          | string    | null: false |
| address       | string    | null: false |
| building_name | string    |             |
| phone_number  | string    | null: false |

### Association

- belongs_to :order