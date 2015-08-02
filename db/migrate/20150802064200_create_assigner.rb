class CreateAssigners < ActiveRecord::Migration
  def change
    create_table :assigners do |t|
      t.