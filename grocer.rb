require 'pry'

def consolidate_cart(cart)
  # code here
  consol_cart = {}
  cart.each do |item|
    item.each do |name, stats|

      if !consol_cart.has_key?(name)
        consol_cart[name]=stats
        consol_cart[name][:count] = 1
      else
        consol_cart[name][:count] += 1
      end #conditional statement
    end #item iteration
  end #cart iteration
  #binding.pry
  consol_cart
end #method


def apply_coupons(cart, coupons)
  #coupon_cart = {}
  coupon_cart = cart
  if coupons.length == 0
    coupon_cart
  end

  coupons.each do |coupon|
    name = coupon[:item]
    if coupon_cart.has_key?(name) && coupon_cart[name][:count] >= coupon[:num]
      coupon_cart[name][:count] -= coupon[:num]
      new_key = "#{name} W/COUPON"
      if coupon_cart.has_key?(new_key)
        coupon_cart[new_key][:count] += 1
      else
        coupon_cart[new_key] = {
          :price => coupon[:cost],
          :clearance => coupon_cart[name][:clearance],
          :count => 1
        }
      end #second conditional
    end #first coupon_cart condional
  end #coupons.each iteration
  coupon_cart
end #method


def apply_clearance(cart)
  # code here
  clear_cart = cart
  clear_cart.each do |item, attributes|


      #binding.pry
      if attributes[:clearance] == true
        attributes[:price] = (attributes[:price].to_f * (0.8)).round(2)
      else
        attributes[:price] = attributes[:price]
      end


  end
  #binding.pry
  clear_cart
end

def checkout(cart, coupons)
  # code here
  consol_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consol_cart, coupons)
  clear_cart = apply_clearance(coupon_cart)

  total = 0

  clear_cart.each do |item, attributes|
    total += attributes[:price] * attributes[:count]
  end

  if total > 100
    total = (total * (0.9)).round(2)
  end
total
end
