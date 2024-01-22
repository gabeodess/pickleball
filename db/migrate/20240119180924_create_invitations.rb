class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :invitations, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :email_or_phone, null: false
      t.belongs_to :group, null: false, foreign_key: true
      t.belongs_to :inviter, null: false, foreign_key: {to_table: :users}
      t.belongs_to :invitee, null: true, foreign_key: {to_table: :users}

      t.index [:email_or_phone, :group_id], unique: true

      t.timestamps
    end
  end
end
