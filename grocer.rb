require 'pry'
def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |item|
    item.each do |name, info|
      if !consolidated_cart[name]
        consolidated_cart[name] = info
        consolidated_cart[name][:count] = 1
      else
        consolidated_cart[name][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  if coupons.length == 0
    return cart
  end
  cart.each do |cart_item_name, cart_item_info|
    new_cart[cart_item_name] = {}
    name_w_coupon = "#{cart_item_name} W/COUPON"
    cart_item_info.each do |item_info, info_value|
      new_cart[cart_item_name][item_info] = info_value
    end
    coupons.each do |coupon|
      # we need to check if a prior coupon has impacted these items to avoid overwriting values
      if coupon[:item] == cart_item_name && !new_cart[name_w_coupon]
          if coupon[:num] <= cart_item_info[:count]
            new_cart[name_w_coupon] = {}
            cart_item_info.each do |item_info, info_value|
              new_cart[name_w_coupon][item_info] = info_value
            end
            new_cart[name_w_coupon][:count] = 1
            new_cart[name_w_coupon][:price] = coupon[:cost]
            new_cart[cart_item_name][:count] -= coupon[:num]
            if new_cart[cart_item_name][:count] <= 0
              new_cart[cart_item_name][:count] = 0
            end
          end
        # since a prior coupon has been used, we update the counts of the existing new_cart records
        elsif coupon[:item] == cart_item_name && new_cart[cart_item_name][:count] >= coupon[:num]
          new_cart[name_w_coupon][:count] += 1
          new_cart[cart_item_name][:count] -= coupon[:num]
        end
      end
    end
  new_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item_name, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(1)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)

  cart_total = 0
  clearanced_cart.each do |cart_item_name, cart_item_info|
    cart_total += cart_item_info[:price] * cart_item_info[:count]
  end
  if cart_total > 100
    cart_total * 0.9
  else
    cart_total
  end
end
