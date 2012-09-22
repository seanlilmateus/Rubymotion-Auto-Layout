class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launch_opts)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |win|
      win.rootViewController = ALViewController.alloc.init 
      win.makeKeyAndVisible
    end
    true
  end
end
