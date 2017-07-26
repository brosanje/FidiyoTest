class AddEmailContraintToUsers < ActiveRecord::Migration[5.1]
  def up
    execute %{
      ALTER TABLE users
        ADD CONSTRAINT email_must_be_valid_email
          CHECK ( email ~* '^[^@]+@[^@]+$' )
    }

    execute %{
      ALTER TABLE users
        ADD CONSTRAINT unconfirmed_email_must_be_valid_email
          CHECK ( unconfirmed_email ~* '^[^@]+@[^@]+$' )
    }
          ## CHECK ( email ~* '^[^@]+@bmo\\.com$' )
  end

  def down
    execute %{
      ALTER TABLE users
        DROP CONSTRAINT email_must_be_valid_email
    }

    execute %{
      ALTER TABLE users
        DROP CONSTRAINT unconfirmed_email_must_be_valid_email
    }
  end
end
