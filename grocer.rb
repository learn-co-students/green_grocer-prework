require "pry"

def consolidate_cart(cart)
  consolidated = {}

  cart.each do |item_hash|
    item_hash.each do |item, item_values|
      if !consolidated[item]
        consolidated[item] = item_values
        consolidated[item][:count] = 1
      else
        consolidated[item][:count] += 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  result = {}
  cart.each_with_object(result) do |(item, h), result|
    coupons.each do |coupon|
      if coupon[:item] == item && coupon[:num] <= cart[item][:count]
        name = "#{item} W/COUPON"
        result[name] ||= {}
        result[name][:price] = coupon[:cost]
        result[name][:clearance] = cart[item][:clearance]
        result[name][:count] ? result[name][:count] += 1 : result[name][:count] = 1
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart.merge!(result)
end


def apply_clearance(cart)
  cart.each do |item, values|
    if cart[item][:clearance]
      cart[item][:price] = cart[item][:price] * 4 / 5
    end
  end
end


def calculate_total(cart)
    total = 0
    cart.each do |item, h|
      total += (cart[item][:price] * cart[item][:count])
    end
    total > 100 ? total *= 0.9 : total = total
    total
end


def checkout(cart, coupons)
  cons = consolidate_cart(cart)
  cons_coup = apply_coupons(cons, coupons)
  all_discounts = apply_clearance(cons_coup)
  calculate_total(all_discounts)
end
