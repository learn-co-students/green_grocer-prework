require 'pry'

def consolidate_cart(cart)
consolidated_cart = {}
  cart.each do |item_type|
    item_type.each do |item, item_data|
      if !consolidated_cart.keys.include? item
        consolidated_cart[item] = item_data
        consolidated_cart[item][:count]=1
      else
        consolidated_cart[item][:count]+=1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if (cart.keys.include? item) && (cart[item][:count] >= coupon[:num])
      if !cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"] = {}
        cart["#{item} W/COUPON"][:price] = coupon[:cost]
        cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        cart["#{item} W/COUPON"][:count] = 1
      elsif cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += 1
      end
      cart[item][:count] = cart[item][:count] - coupon[:num]
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, data|
    new_price = data[:price] * (0.80)
    data[:price] = new_price.round(2) if data[:clearance]
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  sum = 0
  cart.each do |item, data|
    sum += (data[:price] * data[:count])
  end
  sum = (sum * 0.90).round(2) if sum>100
  sum
end
