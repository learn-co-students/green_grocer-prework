require "pry"

def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |key, value|
      if result.has_key?(key)
        value[:count] += 1
      else
        result[key] = value
        value[:count] = 1
      end
    end
  end
end
      #         theCount += 1
      #         cartHash[food][:count] = theCount
      #         binding.pry
      #       else
      #         cartHash[food] = data
      #         cartHash[food][:count] = theCount
      #         binding.pry
      #       end
#
#   #  binding.pry
#   end
#   answer = result
# end
#       binding.pry
# end
# #    hash.each do |food, data|
#       cartHash[food] = data
#       theFood = hash[food]
#       cartHash[food][:count] = 0
#       binding.pry
#       cart.each do |hash_again|
#         binding.pry
#         if theFood == food
#           cartHash[food][:count] += 1
#           binding.pry
#         end
#       end
#     end
#   end
# end
#       if cartHash.has_key?(food)
#         theCount += 1
#         cartHash[food][:count] = theCount
#         binding.pry
#       else
#         cartHash[food] = data
#         cartHash[food][:count] = theCount
#         binding.pry
#       end
#     end
#   end
#   binding.pry
#   return cartHash
# end
#
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    food = coupon[:item]
    if cart[food] && cart[food][:count] >= coupon[:num]
      if cart["#{food} W/COUPON"]
        cart["#{food} W/COUPON"][:count] += 1
      else
        cart["#{food} W/COUPON"] = {count: 1, price: coupon[:cost]}
        cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
      end
      cart[food][:count] -= coupon[:num]
    end
  end
  cart
end
#   # binding.pry
#   cart.each do |item, data|
#     # binding.pry
#     data.each do |category, info|
#       # binding.pry
#       coupons.each do |coupon|
#         # binding.pry
#         coupon.each do |category2, info2|
#   #         binding.pry
#           if item == info2 && data[:count] >= coupon[:num]
#   #           binding.pry
#             if data[:count] == coupon[:num]
#               couponName = "#{item} W/COUPON"
#               cart[couponName] = data
#               cart[couponName][:count] = 1
#               cart[couponName][:price] = coupon[:cost]
#                       #some problem about being not being able to add a key to a hash during an iteration
#               cart.delete(item)
#   #             binding.pry
#                 #remove whole thing from cart and add thing with coupopn as coupon
#             elsif data[:count] > coupon[:num]
#               couponName = "#{item} W/COUPON"
#               cart[couponName] = data
#               cart[couponName][:count] = 1
#               cart[couponName][:price] = coupon[:cost]
#               cart[item][:count] = catr[item][:count] - coupon[:num]
#   #            binding.pry
#               #subtract coup:num from cart item :count and add thing w/ coupon as coupon
#             end
#           else
#           end
#         end
#       end
#     end
#   end
#   #binding.pry
# end
#


def apply_clearance(cart)
  cart.each do |food, data|
    if data[:clearance]
      new_price = data[:price] * 0.8
      data[:price] = new_price.round(2)
    end
  end
  cart
end
# def apply_clearance(cart)
#   cart.each do |hash|
#     hash.each do |food, data|
#     #  binding.pry
#       if hash[food][:clearance] == true
#     #    binding.pry
#         hash[food][:price] = hash[food][:price].to_i * 0.8
#         hash[food][:price] = hash[food][:price].round(2)
#         binding.pry
#       else
#   #      binding.pry
#       end
#     end
#   end
# end
#
def checkout(cart, coupons)
  total = 0
  tidyCart = consolidate_cart(cart)
  coupon_cart = apply_coupons(tidyCart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  clearance_cart.each do |food, data|
    total += data[:price] * data[:count]
  end
  if total > 100
    total = total * 0.9
  end
  total
end
