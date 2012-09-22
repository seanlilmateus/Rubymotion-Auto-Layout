class ALViewController < UIViewController
  def viewDidLoad
    super
    self.view.translatesAutoresizingMaskIntoConstraints = false
    self.view.backgroundColor = UIColor.whiteColor
    
    @top_left_view = UIView.alloc.initWithFrame([[0,0], [200, 200]]).tap do |new_view|
      new_view.translatesAutoresizingMaskIntoConstraints = false
      new_view.backgroundColor = UIColor.magentaColor
      self.view.addSubview(new_view)
    end
    
    @top_right_view = UIView.alloc.initWithFrame([[200, 0], [200, 200]]).tap do |new_view|
      new_view.translatesAutoresizingMaskIntoConstraints = false
      new_view.backgroundColor = UIColor.greenColor
      self.view.addSubview(new_view)
    end    
    
    @bottom_left_view = UIView.alloc.initWithFrame([[200, 0], [200, 200]]).tap do |new_view|
      new_view.translatesAutoresizingMaskIntoConstraints = false
      new_view.backgroundColor = UIColor.blueColor
      self.view.addSubview(new_view)
    end    
    
    @bottom_right_view = UIView.alloc.initWithFrame([[200, 0], [200, 200]]).tap do |new_view|
      new_view.translatesAutoresizingMaskIntoConstraints = false
      new_view.backgroundColor = UIColor.redColor
      self.view.addSubview(new_view)
    end
    
    # you can use layout_subviews or layout_subviews2
    layout_subviews
    NSLog("constraints: %@", self.view.constraints)
  end
  
  # Create a constraint of the form
  def layout_subviews
    views_collection = [ @top_left_view, @top_right_view, @bottom_left_view, @bottom_right_view ]
    @form_contrains = true
    # top_left_view.top == superview.top
    # top_left_view.left == superview.left
    self.view.addConstraints([NSLayoutAttributeTop, NSLayoutAttributeLeft].map do |pos|
      NSLayoutConstraint.constraintWithItem(@top_left_view, 
                                  attribute: pos , 
                                  relatedBy: NSLayoutRelationEqual, 
                                     toItem: self.view,
                                  attribute: pos,
                                 multiplier: 1.0,
                                   constant: 0)
    end)
    
    # top_right_view.top == superview.top
    # top_right_view.right == superview.right
    self.view.addConstraints([NSLayoutAttributeTop, NSLayoutAttributeRight].map do |pos|
      NSLayoutConstraint.constraintWithItem(@top_right_view, 
                                  attribute: pos , 
                                  relatedBy: NSLayoutRelationEqual, 
                                     toItem: self.view,
                                  attribute: pos,
                                 multiplier: 1.0,
                                   constant: 0)
    end)
    
    # bottom_left_view.bottom == superview.bottom
    # bottom_left_view.left == superview.left
    self.view.addConstraints([NSLayoutAttributeBottom, NSLayoutAttributeLeft].map do |pos|
      NSLayoutConstraint.constraintWithItem(@bottom_left_view, 
                                  attribute: pos , 
                                  relatedBy: NSLayoutRelationEqual, 
                                     toItem: self.view,
                                  attribute: pos,
                                 multiplier: 1.0,
                                   constant: 0)
    end)
    
    # bottom_right_view.bottom == superview.bottom
    # bottom_right_view.right == superview.right
    self.view.addConstraints([NSLayoutAttributeBottom, NSLayoutAttributeRight].map do |pos|
      NSLayoutConstraint.constraintWithItem(@bottom_right_view, 
                                  attribute: pos , 
                                  relatedBy: NSLayoutRelationEqual, 
                                     toItem: self.view,
                                  attribute: pos,
                                 multiplier: 1.0,
                                   constant: 0)
    end)
    
    # view.height == (0.5 * self.view.height) - 3.0 pts
    height_constraints = views_collection.map do |view|
      NSLayoutConstraint.constraintWithItem(view, 
                                  attribute: NSLayoutAttributeHeight, 
                                  relatedBy: NSLayoutRelationEqual, 
                                     toItem: self.view,
                                  attribute: NSLayoutAttributeHeight,
                                 multiplier: 0.5,
                                   constant: -3.0)
    end
    self.view.addConstraints(height_constraints)
    
    # view.width == (0.5 * self.view.width) - 3.0
    width_constraints = views_collection.map do |view|
      NSLayoutConstraint.constraintWithItem(view, 
                                  attribute: NSLayoutAttributeWidth, 
                                  relatedBy: NSLayoutRelationEqual, 
                                     toItem: self.view,
                                  attribute: NSLayoutAttributeWidth,
                                 multiplier: 0.5,
                                   constant: -3.0)
    end
    self.view.addConstraints(width_constraints)
  end

  # Create constraints described by an ASCII art-like visual format string
  def layout_subviews2
    metrics = { 'space' => 8 }
    
    views_dict = { 
      "superview" => self.view, 
      "top_left_view" => @top_left_view, 
      "top_right_view" => @top_right_view,
      "bottom_left_view" => @bottom_left_view,
      "bottom_right_view" => @bottom_right_view
    }
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(space)-[top_left_view]-[top_right_view(==top_left_view)]-(space)-|", 
                                                                    options: NSLayoutFormatAlignAllTop, 
                                                                    metrics: metrics, 
                                                                      views: views_dict))
                                                                      
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(space)-[bottom_left_view]-[bottom_right_view(==bottom_left_view)]-(space)-|", 
                                                                    options: NSLayoutFormatAlignAllBottom, 
                                                                    metrics: metrics, 
                                                                      views: views_dict))
                                                                      
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-space-[top_left_view]-[bottom_left_view(==top_left_view)]-space-|", 
                                                                     options: NSLayoutFormatAlignAllLeft, 
                                                                     metrics: metrics, 
                                                                       views: views_dict))
                                                                       
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-space-[top_right_view]-[bottom_right_view(==top_right_view)]-space-|", 
                                                                    options: NSLayoutFormatAlignAllRight, 
                                                                    metrics: metrics, 
                                                                      views: views_dict))
  end
  
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAllButUpsideDown
  end
  
  def preferredInterfaceOrientationForPresentation
    UIInterfaceOrientationLandscapeLeft
  end
  
  def willRotateToInterfaceOrientation(interface_orientation, duration:duration)
    constant = interface_orientation != UIInterfaceOrientationPortrait ? 0.0 : -3.0
    UIView.animateWithDuration(duration, animations:-> { 
      self.view.constraints.last(8).map { |constraint| constraint.constant = constant } 
      self.view.layoutIfNeeded
    }) if @form_contrains
  end  
end