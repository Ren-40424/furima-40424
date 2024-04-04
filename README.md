# テーブル設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| read_first_name    | string | null: false |
| read_last_name     | string | null: false |
| birth              | date   | null: false |

### Association

- has_many :items
- has_many :orders



## itemsテーブル

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| user              | references | null: false, foreign_key: true |
| name              | string     | null: false |
| explanation       | text       | null: false |
| price             | integer    | null: false |
| category_id       | integer    | null: false |
| condition_id      | integer    | null: false |
| shipping_payer_id | integer    | null: false |
| prefecture_id     | integer    | null: false |
| shipping_date_id  | integer    | null: false |

### Association

- belongs_to :user
- has_one :order



## ordersテーブル

| Column      | Type       | Options     |
| ----------- | ---------- | ----------- |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination



## destinationsテーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| order         | references | null: false, foreign_key: true |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| address       | string     | null: false |
| building_name | string     |             |
| phone_number  | string     | null: false |

### Association

- belongs_to :order