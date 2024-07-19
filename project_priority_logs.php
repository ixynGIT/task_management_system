<?php include'db_connect.php' ?>
<div class="col-lg-12">
	<div class="card card-outline card-secondary">
		<div class="card-body">
			<table class="table tabe-hover table-bordered" id="list">
				<thead>
					<tr>
						<th class="text-center">#</th>
						<th>Project</th>
						<th>Old Priority</th>
						<th>New Priority</th>
						<th>Changed On</th>
					</tr>
				</thead>
				<tbody>
					<?php
					$prio = array("", "IMPORTANT!","MODERATE","LEAST");
					$i = 1;
					$qry = $conn->query("SELECT * FROM project_list_priority_changes");
					while($row= $qry->fetch_assoc()):
					?>
					<tr>
						<th class="text-center"><?php echo $i++ ?></th>
						<td><b><?php echo $row['Project'] ?></b></td>
						<td><b><?php if($prio[$row['Old Priority']] =='IMPORTANT!'){
							  	echo "<span class='badge rounded-pill bg-danger'>{$prio[$row['Old Priority']]}</span>";
							  }elseif($prio[$row['Old Priority']] =='MODERATE'){
							  	echo "<span class='badge rounded-pill bg-warning'>{$prio[$row['Old Priority']]}</span>";
							  }elseif($prio[$row['Old Priority']] =='LEAST'){
							  	echo "<span class='badge rounded-pill bg-secondary'>{$prio[$row['Old Priority']]}</span>";
							  }?></b></td>
						<td><b><?php if($prio[$row['New Priority']] =='IMPORTANT!'){
							  	echo "<span class='badge rounded-pill bg-danger'>{$prio[$row['New Priority']]}</span>";
							  }elseif($prio[$row['New Priority']] =='MODERATE'){
							  	echo "<span class='badge rounded-pill bg-warning'>{$prio[$row['New Priority']]}</span>";
							  }elseif($prio[$row['New Priority']] =='LEAST'){
							  	echo "<span class='badge rounded-pill bg-secondary'>{$prio[$row['New Priority']]}</span>";
							  }?></b></td>
						<td><b><?php echo $row['Changed On'] ?></b></td>
					</tr>
				<?php endwhile; ?>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$('#list').dataTable()
	})

</script>