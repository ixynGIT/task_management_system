  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <div class="dropdown">
   	<a href="./" class="brand-link">
        <?php if($_SESSION['login_type'] == 1): ?>
        <h3 class="text-center p-0 m-0"><b>ADMIN</b></h3>
        <?php else: ?>
        <h3 class="text-center p-0 m-0"><b>USER</b></h3>
        <?php endif; ?>

    </a>
      
    </div>
    <div class="sidebar pb-4 mb-4">
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column nav-flat" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item dropdown">
            <a href="./" class="nav-link nav-home">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>  
          <li class="nav-item">
            <a href="#" class="nav-link nav-edit_project nav-view_project">
              <i class="nav-icon fas fa-layer-group"></i>
              <p>
                Projects
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
            <?php if($_SESSION['login_type'] != 3): ?>
              <li class="nav-item">
                <a href="./index.php?page=new_project" class="nav-link nav-new_project tree-item">
                  <i class="fas fa-plus nav-icon"></i>
                  <p>New Project</p>
                </a>
              </li>
            <?php endif; ?>
              <li class="nav-item">
                <a href="./index.php?page=project_list" class="nav-link nav-project_list tree-item">
                  <i class="fas fa-angle-right nav-icon"></i>
                  <p>All Projects</p>
                </a>
              </li>
            </ul>
          </li> 
          <li class="nav-item">
                <a href="./index.php?page=task_list" class="nav-link nav-task_list">
                  <i class="fas fa-tasks nav-icon"></i>
                  <p>Tasks</p>
                </a>
          </li>
          <?php if($_SESSION['login_type'] != 3): ?>
           <li class="nav-item">
                <a href="./index.php?page=reports" class="nav-link nav-reports">
                  <i class="fas fa-th-list nav-icon"></i>
                  <p>Report</p>
                </a>
          </li>
          <?php endif; ?>
          <?php if($_SESSION['login_type'] == 1): ?>
          <li class="nav-item">
            <a href="#" class="nav-link nav-edit_user">
              <i class="nav-icon fas fa-users"></i>
              <p>
                Users
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="./index.php?page=new_user" class="nav-link nav-new_user tree-item">
                  <i class="fas fa-plus nav-icon"></i>
                  <p>New User</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index.php?page=user_list" class="nav-link nav-user_list tree-item">
                  <i class="fas fa-angle-right nav-icon"></i>
                  <p>All Users</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link nav-edit_user">
              <i class="nav-icon fas fa-archive"></i>
              <p>
                Logs
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="./index.php?page=project_priority_logs" class="nav-link nav-project_priority_logs tree-item">
                  <i class="fas fa-history nav-icon"></i>
                  <p>Project Priority Logs</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index.php?page=tasks_completed" class="nav-link nav-tasks_completed tree-item">
                  <i class="fas far fa-calendar-check nav-icon"></i>
                  <p>Tasks Completed Archive</p>
                </a>
              </li>
            </ul>
          </li>
        <?php endif; ?>
        <li class="nav-item">
                   <a href="#" class="nav-link">
                     <i class="nav-icon fas fa-bolt"></i>
                     <p>
                       Smart Commands
                       <i class="right fas fa-angle-left"></i>
                     </p>
                   </a>
                   <ul class="nav nav-treeview">
                     <li class="nav-item">
                       <a href="#" class="nav-link tree-item dropdown-toggle float" data-toggle="dropdown" aria-expanded="true">
                         <i class="fas fa-eye nav-icon"></i>
                         <p>View</p>
                       </a>
                       <div class="dropdown-menu">
                          <button class="dropdown-item text-dark" onclick="getTotalProjects()" href="javascript:void(0)">Get Total Projects</button>
                          <div class="dropdown-divider"></div>
                          <button class="dropdown-item text-dark" onclick="getTotalTasks()" href="javascript:void(0)">Get Total Tasks</button>
                      </div>
                     </li>
                     <?php if($_SESSION['login_type'] != 3): ?>
                     <li class="nav-item">
                       <a href="#" class="nav-link tree-item dropdown-toggle float" data-toggle="dropdown" aria-expanded="true">
                         <i class="fas fa-trash-alt nav-icon"></i>
                         <p>Delete</p>
                       </a>
                       <div class="dropdown-menu">
                          <button class="dropdown-item text-dark" onclick="deleteProject()" href="javascript:void(0)">Delete Project</button>
                          <div class="dropdown-divider"></div>
                          <button class="dropdown-item text-dark" onclick="deleteTask()" href="javascript:void(0)">Delete Task</button>
                      </div>
                     </li>
                      <?php endif; ?>

                   </ul>
        </li>
        </ul>
      </nav>
    </div>
  </aside>
  <script>
  	$(document).ready(function(){
      var page = '<?php echo isset($_GET['page']) ? $_GET['page'] : 'home' ?>';
  		var s = '<?php echo isset($_GET['s']) ? $_GET['s'] : '' ?>';
      if(s!='')
        page = page+'_'+s;
  		if($('.nav-link.nav-'+page).length > 0){
             $('.nav-link.nav-'+page).addClass('active')
  			if($('.nav-link.nav-'+page).hasClass('tree-item') == true){
            $('.nav-link.nav-'+page).closest('.nav-treeview').siblings('a').addClass('active')
  				$('.nav-link.nav-'+page).closest('.nav-treeview').parent().addClass('menu-open')
  			}
        if($('.nav-link.nav-'+page).hasClass('nav-is-tree') == true){
          $('.nav-link.nav-'+page).parent().addClass('menu-open')
        }

  		}
     
  	})
  </script>