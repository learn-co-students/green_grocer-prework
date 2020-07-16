def consolidate_cart(cart)
  hash = {}
  pre_item = nil
  count = 1
  
  cart.each do |item|
    if pre_item == nil || pre_item != item
      count = 1
      pre_item = item
    else  
      count += 1
    end
    
    item.each do |name, data|
      data.each do |attribute, value|
        if hash[name] == nil
          hash[name] = {attribute => value}
        else
          hash[name][attribute] = value
        end
      end
      
      hash[name][:count] = count
    end
  end
  
  hash  
end

def apply_coupons(cart, coupons)
  hash = {}
  
  cart.each do |item, attribute|
    if coupons.length != 0
      coupons.each do |coupon_attribute|
        if item == coupon_attribute[:item]
          count = attribute[:count] / coupon_attribute[:num]
          if count >= 1
          hash["#{item} W/COUPON"] = {:price => coupon_attribute[:cost], :clearance => attribute[:clearance], :count => count}
        
          remainder = attribute[:count] % coupon_attribute[:num]
          hash[item] = {:price => attribute[:price], :clearance => attribute[:clearance], :count => remainder}
          end
        elsif hash[item] == nil
          hash[item] = attribute
        end
      end
    else
      hash[item] = attribute
    end
  end
  
  hash
end

def apply_clearance(cart)
  hash = {}
  
  cart.each do |key, value|
    if value[:clearance] == true
      hash[key] = {:price => (value[:price] * 0.8).round(2), :clearance => value[:clearance], :count => value[:count]}
    else
      hash[key] = value
    end
  end
  
  hash
end

def checkout(cart, coupons)
  hash = {}
  hash = consolidate_cart(cart)
  hash = apply_coupons(hash, coupons)
  hash = apply_clearance(hash)
  total = 0
  
  hash.each do |item, attribute|
    total += attribute[:price] * attribute[:count]
  end
  
  total > 100 ? total * 0.9 : total
end