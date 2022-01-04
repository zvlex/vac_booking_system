module Users
  class UserService
    attr_reader :current_user, :result

    def initialize(current_user)
      @current_user = current_user
      @result = OpenStruct.new(success?: false, user: User.new)
    end

    def list
      User.all
    end

    def new
      result
    end

    def edit(id)
      find_record(id)
    end

    def create(params)
      result.tap do |r|
        r.user = User.new(params)
        r.send("success?=", r.user.save)
      end
    end

    def update(id, params)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.user.update(params))
      end
    end

    def delete(id)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.user.destroy)
      end
    end

    private

    def find_record(id)
      result.user = User.find(id)
      result
    end
  end
end
