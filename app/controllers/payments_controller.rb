class PaymentsController < ApplicationController
    def index
        @payment = Payment.order(:first_name)
    end

    def show
        @user = User.find(params[:id])
        @payment = @user.payment
    end

    def new
        @user = User.find(params[:user_id])
        @payment = Payment.new
    end

    def create
       @payment = Payment.new(payment_params) 
       @payment.user_id = params[:user_id]
        if @payment.save
            redirect_to user_payments_path
        else
            render('new')
        end
    end

    private
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number, :cvv, :exp_month, :exp_year)
    end

end
  

# #   def edit
# #     @payment = Payment.find(params[:id])
# #   end

# #   def update
# #     @payment = Payment.find(params[:id])
# #     if @payment.update(payment_params)
# #         redirect_to payment_path(@payment)
# #     else
# #         render('edit')
# #     end
# #   end

# end
