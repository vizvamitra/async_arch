module Users
  class Create
    # @param public_id [String]
    # @param email [String]
    # @param role [String]
    # @param first_name [String]
    # @param last_name [String]
    #
    # @return [User]
    # @raise [KeyError]
    # @raise [ActiveRecord::RecordNotUnique]
    #
    def call(public_id:, **attributes)
      user = Auth::User.find_or_initialize_by(uid: public_id)
      sync(user, **attributes)

      user
    end

    private

    def sync(user, attributes)
      user.update!(
        provider: "doorkeeper",
        email: attributes.fetch(:email),
        role: attributes.fetch(:role),
        first_name: attributes.fetch(:first_name),
        last_name: attributes.fetch(:last_name)
      )
    end
  end
end
