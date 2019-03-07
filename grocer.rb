def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    item_name = item.keys[0]
    if !new_cart.include?(item_name)
      new_cart[item_name] = item[item_name]
      new_cart[item_name][:count] = 1
    else
      new_cart[item_name][:count] = new_cart[item_name][:count]+1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  couponed_items = []

  def lookup_cost(coupons,item_name)
    coupons.each do |coupon|
      if coupon[:item] == item_name
        return coupon[:cost]
      end
    end
  end

  def lookup_num(coupons,item_name)
    coupons.each do |coupon|
      if coupon[:item] == item_name
        return coupon[:num]
      end
    end
  end

  def num_coupons(coupons,item_name)
    num = 0
    coupons.each do |coupon|
      if coupon[:item] == item_name
        num += 1
      end
    end
    num
  end

  # collect the names of items that have a coupon
  coupons.each do |coupon|
    couponed_items << coupon[:item]
  end

  cart.each do |item_name,item_data|
    new_cart[item_name] = item_data
    if couponed_items.include?(item_name)
      num_coupons(coupons,item_name).times do
        if new_cart[item_name][:count] >= lookup_num(coupons,item_name)
          new_cart[item_name][:count] = new_cart[item_name][:count] - lookup_num(coupons,item_name)
          if !new_cart[item_name+" W/COUPON"]
            new_cart[item_name+" W/COUPON"] = {
              :price => lookup_cost(coupons,item_name),
              :clearance => item_data[:clearance],
              :count => 0
            }
          end
          new_cart[item_name+" W/COUPON"][:count] = new_cart[item_name+" W/COUPON"][:count] + 1
        end
      end
    end
  end

  new_cart
end

def apply_clearance(cart)
  new_cart = {}
  cart.each do |item_name,item_data|
    new_cart[item_name] = item_data
    if new_cart[item_name][:clearance]
      new_price = (new_cart[item_name][:price].to_f * 0.8).round(2)
      new_cart[item_name][:price] = new_price
    end
  end
  new_cart
end

def checkout(cart, coupons)
  couponed_cart = apply_coupons(consolidate_cart(cart),coupons)
  clearanced_couponed_cart = apply_clearance(couponed_cart)
  total = 0.0
  clearanced_couponed_cart.each do |item_name,item_data|
    total += item_data[:price]*item_data[:count]
  end

  if total > 100
    total = total * 0.9
  end

  total
end
