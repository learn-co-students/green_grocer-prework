require "pry"
def consolidate_cart(cart)
  # binding.pry
  new_hash = {}
  cart.each do |ele|
    ele.each do |name, attribute|
        # binding.pry
      if !new_hash.has_key?(name)
        new_hash[name] = attribute
        new_hash[name][:count] = 1
      else
        new_hash[name][:count] += 1
      end
    end
  end
  new_hash
end


def apply_coupons(cart, coupons)
  # {:item => "Avocado", :num => 2, :cost => 5.0}
  # {"Avocado" => {price: 3.0, :clearance:true, count:3}}
  #you want to iterate over coupon first

  coupons.each do |coupon|
    name = coupon[:item]  #avocado
    if cart.has_key?(name)
      item_count = cart[name][:count] #2
      # binding.pry
      if item_count >= coupon[:num]
        with_coup = {"#{name} W/COUPON" => {:price => coupon[:cost],
          :clearance => cart[name][:clearance],
          :count => item_count/coupon[:num]}}
          # binding.pry
          cart[name][:count] %= coupon[:num]
          cart = cart.merge(with_coup)
        end
      end
    end
    cart
end

def apply_clearance(cart)
  cart.each do |name, attribute|
    if attribute[:clearance] == true
      attribute[:price] = (attribute[:price] * 0.80).round(1)
    end
  end
  return cart
end


def checkout(cart, coupons)
  current_cart = consolidate_cart(cart)
  cart_w_coupon = apply_coupons(current_cart, coupons)
  discount_cart = apply_clearance(cart_w_coupon)

  total = 0
  discount_cart.each do |name, attribute|
    total += attribute[:count] * attribute[:price]
  end
  return total = total > 100 ? (total * 0.9).round(2) : total
end
