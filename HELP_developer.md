You can provide details about recent activity for other areas of your site,
or for other extensions in your system.

Dashboard comes with regions that you may edit just like any other area of 
the Radiant interface.

## For Extension Developers

First, be sure to load Dashboard first if you are adding regions to the view.
Set up your `config/environment.rb` like

    config.extensions = [:dashboard, :all]
    
Because extensions are loaded alphabetically (the order of their names in `vendor/extensions`)
An extension such as the [Blog](http://ext.radiantcms.org/extensions/30-blog) extension may
add a region but due to the alphabetical loading (blog comes before dashboard) the Dashboard
regions have not yet been initialized, and the Blog regions will not appear. To avoid this, 
setup your extensions to load in the proper order.

### Dashboard Regions

If you would like to provide some information about your extension to users
but the information doesn't present the need for another tab in the main
navigation of the admin area, you can easily add your information to the
Dashboard instead.

Here's an example used by [Site Watcher](http://ext.radiantcms.org/extensions/41-site-watcher)

	
		def activate
		if admin.respond_to?(:dashboard)
			admin.dashboard.index.add :extensions, 'popular_pages'
		end
	end
	
Site Watcher adds Radius tags to the system to list popular pages on your 
public website. It's not necessary for the extension to list these pages
for site editors, but it would be convenient. So Dashboard fills the gap of
providing a small area to display information for Site Watcher when a main
navigation tab would be unnecessary.

For another example of its use, see [Featured Pages](http://ext.radiantcms.org/extensions/42-featured-pages)

### Dashboard Helper

Dashboard comes with a simple helper to display the name of the user who
most recently update a particular object. You may use `updater_name_for(your_object)`

By default the `updater_name_for` helper will find the name of the user
listed as the `updated_by_id`. If that field is empty, it will find the user
listed as the `created_by_id`. If that field is empty, it will display 
"Radiant System" as the updaters name.

If you need a more complex result, or if you would like to provide some
other default result, you may user the `associations`, `attribute`, and 
`not_found` arguments:

	updater_name_for(page, :associations => [:reviewed_by_id, :approved_by_id], :attribute => :login, :not_found => 'Nobody')
		
The `updater_name_for` method will loop through the `:associations` in the 
order that they are provided, if the association exists it will ask for the 
provided `:attribute` and if none of these are found it will display the 
`:not_found` argument.

The above example assumes a theoretical extension that adds the fields 
`reviewed_by_id` and `approved_by_id` to the pages table. If those fields
are empty (or NULL) in the database, the result would be "Nobody"

If none of these are provided the default values will be `[:updated_by, :created_by]`,
`:name` and `Radiant System`.

### CSS

Each default Dashboard module is defined in HTML as:

	<div id="..." class="dashboard_module">
		<h2>...Title...</h2>
		<p>...optional message...</p>
		... your details...
	</div>
	
If you would like to keep your modules up to date with the default CSS, be sure
to use this structure and to include the class `dashboard_module`.