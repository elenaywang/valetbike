class PaymentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_user, only: [:new, :show, :edit]
    before_action :check_payment, only: [:show, :edit]

    # def index
    #     @payment = Payment.order(:first_name)
    # end

    # def show
    #     #@user = current_user
    #     @payment = Payment.find_by(user_id: current_user.id)
    # end

    def new
        @user = current_user
        if @user.payment_id.blank?
            @user = current_user
            @payment = Payment.new
        else
            redirect_to edit_user_payment_path(id: current_user.payment_id)
        end

    end

    def create
        @user = current_user
        if @user.payment_id.blank? 
            @payment = Payment.new(payment_params) 
            @payment.user = @user
                if @payment.save                        
                    flash.notice = "Payment information saved"

                    #@user.payment = @payment
                    current_user.update_column(:payment_id, @payment.id)
                    redirect_to profile_home_index_path
                else
                    flash.now[:alert] ||= ""
                    @payment.errors.full_messages.each do |message|
                    flash.now[:alert] << message + ". "
                    end      
                    render(action: :new)
                    # flash.alert = "Unable to save payment information. Please ensure all information is valid."
                    # redirect_to new_user_payment_path
                end
        else
            redirect_to user_payment_path
        end
    end

    def edit
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def update
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
        if @payment.update(payment_params)
            flash.notice = "Payment information updated"
            redirect_to profile_home_index_path
        else
            # flash.alert = "Unable to update payment information. Please ensure all information is valid."
            # redirect_to edit_user_payment_path
            flash.now[:alert] ||= ""
            @report.errors.full_messages.each do |message|
              flash.now[:alert] << message + ". "
            end      
            render(action: :new)
        end
    end

    def check_user
        if current_user.id != params[:user_id].to_i
            #redirect_to user_payments_path(current_user)
            redirect_to profile_home_index_path
            #change this redirect to take you back to profile editing page
        end
    end
    
    def check_payment
        if current_user.payment_id != params[:id].to_i
            #redirect_to user_payments_path(current_user)
            redirect_to profile_home_index_path
            #change redirect to take you back to profile
        end
    end

    private
    
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number, :cvv, :exp_month, :exp_year)
    end

end
