class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true

    before_create :create_referral_code
    # Email currently disabled - need email html!
    #after_create :send_welcome_email

    REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "Additional $10 off any item",
            "class" => "two"
        },
        {
            'count' => 10,
            "html" => "Free Silk Black Bow Tie",
            "class" => "three"
        },
        {
            'count' => 25,
            "html" => "$30 off any item on the site",
            "class" => "four"
        },
        {
            'count' => 50,
            "html" => "Free Shirt",
            "class" => "five"
        },
        {
            'count' => 100,
            "html" => "Free Custom Suit",
            "class" => "six"
        }
    ]

    private

    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

    def send_welcome_email
        UserMailer.delay.signup_email(self)
    end
end
