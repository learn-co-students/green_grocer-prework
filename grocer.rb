require 'pry'

def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |food, data|
      amount = cart.count {|i| i.include?(food)}
      result[food] ||= data
      data[:count] ||= amount
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    couponed_item = coupon[:item]
    couponed = couponed_item + " W/COUPON"
    if cart[couponed_item] == nil
      return cart
    elsif cart[couponed_item][:count] >= coupon[:num]
      new_price = coupon[:cost]
      clearance = cart[couponed_item][:clearance]
      count = cart[couponed_item][:count] / coupon[:num]
      cart[couponed] = {
        :price => new_price,
        :count => count,
        :clearance => clearance
      }
      cart[couponed_item][:count] = cart[couponed_item][:count] % coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  if cart.is_a?(Array)
    cart = consolidate_cart(cart)
  else
    cart = cart
  end
  cart.each do |items, data|
    if cart[items][:clearance] == true
      cart[items][:price] = cart[items][:price] - (0.20 * cart[items][:price])
    end
  end
  cart
end


def checkout(cart, coupons)
  cost = 0.00
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item, data|
    cost += data[:price] * data[:count]
  end
  if cost > 100
    cost = cost - (cost/10)
  end
  cost
end
