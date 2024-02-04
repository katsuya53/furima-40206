## users テーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| nickname           | string | null: false                |
| email              | string | null: false, unique: true  |
| encrypted_password | string | null: false                |
| first-name         | string | null: false                |
| last-name          | string | null: false                |
| first-name-kana    | string | null: false                |
| last-name-kana     | string | null: false                |
| birth-date         | string | null: false                |


### Association

- has_many :items
- has_many :orders


## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| sales-status        | string     | null: false                    |
| shipping-fee-status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled-delivery  | string     | null: false                    |
| price               | string     | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipp


## shipps テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal-code      | string     | null: false                    |
| prefecture       | string     | null: false                    |
| city             | string     | null: false                    |
| addresses        | string     | null: false                    |
| building         | string     |                                |
| phone-number     | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to :order