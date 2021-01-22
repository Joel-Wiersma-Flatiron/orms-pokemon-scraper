class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        self.id = :id
        self.name = :name
        self.type = :type
        self.db = :db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.new_from_db(row, db)
        pokemon = Pokemon.new(id: nil, name: nil, type: nil, db: db)
        pokemon.id = row[0]
        pokemon.name = row[1]
        pokemon.type = row[2]
        pokemon
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
        SQL
        db.execute(sql, id).map do |row|
            self.new_from_db(row, db)
        end.first

    end
end
