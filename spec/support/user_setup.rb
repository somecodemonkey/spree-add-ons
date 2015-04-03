module ApiHelpers
  def sign_in_as_admin!
    let!(:current_api_user) do
      user = stub_model(Spree.user_class)
      user.stub_chain(:spree_roles, :pluck).and_return(["admin"])
      user.stub(:has_spree_role?).with("admin").and_return(true)
      user
    end
  end

  def stub_authentication!
    Spree.user_class.stub(:find_by).with(hash_including(:spree_api_key)) { current_api_user }
  end

  # This method can be overriden (with a let block) inside a context
  # For instance, if you wanted to have an admin user instead.
  def current_api_user
    @current_api_user ||= stub_model(Spree.user_class, :email => "spree@example.com")
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :controller
end
