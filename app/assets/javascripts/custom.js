$(document).on('ready page:load', function(event) {
  $(".destroy").hide();
  $(".chkbox").change(function() {
    $(this).siblings('.destroy').prop('checked', !this.checked);
  });
});

$(document).on('ready page:load', function(event) {
  $(".skills_filter").on("click", function() {
    var ids = [];
    search_val = $('.search').val();
    $('.skills_filter:checked').map(function () {
      ids.push(this.value);
    })
    $.ajax({
      type: "GET",
      url: "/jobs/",
      data: { filter_by: ids, search_key: search_val },
      success: function(data) {
        return false
      },
      error: function(data) {
        return false
      }
    });
  });
});

$(document).on('ready page:load', function(event) {
  $('.accept').on("click", function(){
    job_id = $('.hidden_job_id').val();
    seeker_id = $(this).data('job-seeker');
    $('#declineJobModal').modal();
    $('.job_id').val(job_id);
    $('.seeker_id').val(seeker_id);
  });
});

// $('.accept').data('job-id')
// $.post "/jobs/"
// url: "/jobs/" + hidden_value + "/edit",
// data: { id: hidden_value },
// success: function(data) {
//   data.title
//   $('#').val(data.title);
// }

// and in controller
// jod = Job.find(params[:id])
// render json: { title: job.title, name: job.name } # 'new'