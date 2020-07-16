require "pry"
def consolidate_cart(cart)
  result = Hash.new

  cart.each do |item|
    item.each do |item_name, item_data|
      # If the item is not added to consolidated cart
      if result.include?(item_name)
        result[item_name][:count] += 1
      else # If item is added to consolidated cart
        result[item_name] = Hash.new
        item_data.each do |key, value|
          result[item_name][key] = value
        end
        result[item_name][:count] = 1
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  couponed_cart = cart.clone

  # find couponed item
  cart.each do |item_name, item_data|
    coupons.each do |coupon|
      if coupon[:item] == item_name && item_data[:count] - coupon[:num] >= 0
        couponed_cart[item_name][:count] -= coupon[:num] # subtract quantity indicated on coupon

        # add discounted rate to consolidated cart line
        if !couponed_cart.include?("#{item_name} W/COUPON")
          couponed_cart["#{item_name} W/COUPON"] = Hash.new
          couponed_cart["#{item_name} W/COUPON"][:price] = coupon[:cost]
          couponed_cart["#{item_name} W/COUPON"][:clearance] = item_data[:clearance]
          couponed_cart["#{item_name} W/COUPON"][:count] = 1
        else
          couponed_cart["#{item_name} W/COUPON"][:count] += 1
        end
      end
    end
  end
  couponed_cart
end

def apply_clearance(cart)
  cart.each do |item_name, item_data|
    if item_data[:clearance]
      item_data[:price] = (0.8 * item_data[:price]).round(2)
    end
  end
end

def checkout(cart, coupons)
  subtotal_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  subtotal = 0.0;
  subtotal_cart.each do |item_name, item_data|
    subtotal += item_data[:count] * item_data[:price]
  end
  subtotal > 100 ? (0.9 * subtotal).round(2) : subtotal
end
