require "pry"


def consolidate_cart(array)
    count = Hash.new(0)
    array.each do |foods|
        count[foods] += 1
    end
    result = Hash.new
    count.each do |foods,count_num|
        foods.each do |food,specs|
            result[food] = specs
            result[food][:count] = count[foods]
        end
    end
    result
end


def apply_coupons(cart, coupons)
    result = {}
    result = cart
    coupon_count = Hash.new(0)
    coupons.each do |coup|
        coupon_count[coup] += 1
        if result.keys.include?(coup[:item]) && result[coup[:item]][:count] >= coup[:num]
            result[coup[:item] + " W/COUPON"] = {:price =>coup[:cost], :clearance => cart[coup[:item]][:clearance], :count => coupon_count.values[0]}
            result[coup[:item]][:count] -= coup[:num]
        end
    end
    result
end


def apply_clearance(cart)
    result = {}
    cart.each do |attr,value|
        if value[:clearance] == true
            discount_percent = value[:price] * 0.80
            result[attr] = value
            result[attr][:price] = discount_percent.round(2)
        else
            result[attr] = value
        end
    end
end

def checkout(cart, coupons)
    item_price = 0
    consolidated_cart = consolidate_cart(cart)
    
    applied_coupons = apply_coupons(consolidated_cart, coupons)
    applied_clearance = apply_clearance(applied_coupons)
    
    applied_clearance.each do |attr, value|
        if value[:count] > 0
            value[:price] *= value[:count]
            item_price += value[:price]
        end
    end
    if item_price > 100
        item_price * 0.90
    else
        item_price
    end
end


#def apply_coupons(cart, coupons)
#    result = {}
#    cart.each do |attr, value|
#        result[attr] = value
#        coupon_count = Hash.new(0)
#        coupons.each do |coup|
#            coupon_count[coup] += 1
#            if coup[:item] == attr
#                result[attr + " W/COUPON"] = {:price =>coup[:cost], :clearance => value[:clearance], :count => coupon_count.values[0]}
#                result[attr][:count] -= coup[:num]
#                
#            end
#        end
#    end
#    result
#end
#

