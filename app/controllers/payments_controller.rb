class PaymentsController < ApplicationController
    #validators for form input here

    # def index
    #     @payment = Payment.order(:first_name)
    # end

    def show
        #@user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def new
        @user = current_user
        @payment = Payment.new
    end

    def create
       if current_user.payment_id.blank?
        @payment = Payment.new(payment_params) 
        @payment.user_id = params[:user_id]
            if @payment.save
                flash.notice = "Payment information saved"
                current_user.update_column(:payment_id, @payment.id)
                redirect_to user_payments_path
            else
                flash.alert = "Unable to save payment information"
                render('new')
            end
        else
            redirect_to user_payments_path
        end
    end

    def edit
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def update
        @payment = Payment.find_by(user_id: current_user.id)
        if @payment.update(payment_params)
            redirect_to user_payments_path
        else
            render ('edit')
        end
    end

    private
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number, :cvv, :exp_month, :exp_year)
    end

end
