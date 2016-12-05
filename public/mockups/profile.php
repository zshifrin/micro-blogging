<?php require '_header.php'; ?>

<div class="container">
	<div class="row">
		<div class="col-md-4">
			<img src="http://placehold.it/250x250" class="img-responsive" alt="responsive profile image">
			<h2>Username</h2>
			<button type="button" class="btn btn-sm btn-primary">Follow</button>
			<!-- change to follow button class to btn-danger and text to Unfollow if user is already followed -->
			<p id="profileBio">Bio: Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate perspiciatis nam facilis aperiam fuga itaque incidunt delectus, reprehenderit veniam ratione minima, possimus voluptas aliquid sed temporibus, excepturi, modi voluptatibus. Adipisci.</p>
		</div>

		<div class="col-md-8">
		<input type="text" class="form-control" placeholder="Post Title">
		<textarea class="form-control" id="postBodyForm" rows="6"></textarea>
		<button type="submit" class="btn btn-default">Submit</button>
		</div>
	</div>
	<div class="row">
		<div class="col-md-8 col-md-offset-4">
			<h1>User's Posts Go here</h1>
		</div>
	</div>
</div>
<?php require '_footer.php'; ?>