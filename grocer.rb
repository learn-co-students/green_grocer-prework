require "pry"

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |product_hash|
    product_hash.each do |product_name, product_info|
      if !new_cart.keys.include?(product_name)
        new_cart[product_name] = product_info
        new_cart[product_name][:count] = 0
      end
      new_cart[product_name][:count] += 1
    end
  end
  new_cart
end


def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |product_name, product_info|
    coupons.each do |coupon|
      if coupon[:item] == product_name
        if product_info[:count] >= coupon[:num]
          if new_cart["#{product_name} W/COUPON"] == nil
              new_cart["#{product_name} W/COUPON"] = {}
              new_cart["#{product_name} W/COUPON"][:price] = coupon[:cost]
              new_cart["#{product_name} W/COUPON"][:clearance] = product_info[:clearance]
              new_cart["#{product_name} W/COUPON"][:count] = 0
            end

          while product_info[:count] - coupon[:num] >= 0
              product_info[:count] -= coupon[:num]
              new_cart["#{product_name} W/COUPON"][:count] += 1
          end

          if product_info[:count] >= 0
            new_cart[product_name] = product_info
          end
        end
      end
    end
    if !new_cart.keys.include?(product_name)
      new_cart[product_name] = product_info
    end
  end
  new_cart
end


def apply_clearance(cart)
  cart.each do |product_name, product_info|
    if product_info[:clearance]
      new_price = product_info[:price] * 0.8
      product_info[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(applied_coupons)
  total = 0
  final_cart.each do |product_name, product_info|
    total += product_info[:price] * product_info[:count]
  end
  if total > 100
    total *= 0.9
  end
  total
end
