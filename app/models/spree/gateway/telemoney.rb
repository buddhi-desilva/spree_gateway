module Spree
  class Gateway::Telemoney < Gateway
    preference :mid, :string
    preference :test_url, :string
    preference :live_url, :string
    preference :refund_auth_code, :string

    attr_accessible :preferred_mid, :preferred_test_url, :preferred_live_url, :preferred_refund_auth_code


    def provider_class
      ActiveMerchant::Billing::TelemoneyGateway
    end

    def authorize(money, credit_card, gateway_options)
      gateway_options[:userfield1] = gateway_options[:order_id]
      provider.authorize(money, credit_card, gateway_options)
    end

    def capture(money, authorization, gateway_options)
      provider.capture(money, authorization, gateway_options)
    end

    def purchase(money, credit_card, gateway_options)
      gateway_options[:userfield1] = gateway_options[:order_id]
      provider.purchase(money, credit_card, gateway_options)
    end

    def void(authorization, gateway_options)
      provider.void(authorization, gateway_options)
    end

    def refund(authorization, gateway_options)
      provider.refund(authorization, gateway_options)
    end

  end
end
