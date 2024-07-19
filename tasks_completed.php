<?php include'db_connect.php' ?>
<div class="col-lg-12">
	<div class="card card-outline card-dark">
		<div class="card-body">
			<table class="table tabe-hover table-bordered" id="list">
				<thead>
					<tr>
						<th class="text-center">#</th>
						<th>Project</th>
						<th>Task</th>
						<th>Started On</th>
						<th>Completed On</th>
					</tr>
				</thead>
				<tbody>
					<?php
					$i = 1;;
					$qry = $conn->query("SELECT * FROM task_list_completed");
					while($row= $qry->fetch_assoc()):
					?>
					<tr>
						<th class="text-center"><?php echo $i++ ?></th>
						<td><b><?php echo $row['Project'] ?></b></td>
						<td><b><?php echo $row['Task'] ?></b></td>
						<td><b><?php echo $row['Started On'] ?></b></td>
						<td><b><?php echo $row['Completed On'] ?></b></td>
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