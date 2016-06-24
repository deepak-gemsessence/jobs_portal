$(document).ready(function() {
  $(".destroy").hide();
  $(".chkbox").change(function() {
    $(this).siblings('.destroy').prop('checked', !this.checked);
  });
});

// $(document).ready(function() {
//   $("#user_skill_sets_attributes_0__destroy").hide();
//   $("#user_skill_sets_attributes_1__destroy").hide();
//   $("#user_skill_sets_attributes_2__destroy").hide();
//   $("#user_skill_sets_attributes_0_skill_id").change(function() {
//     if(this.checked) {
//       $("#user_skill_sets_attributes_0__destroy").hide();
//       $('#user_skill_sets_attributes_0__destroy').prop('checked', false);
//     } else {
//       $("#user_skill_sets_attributes_0__destroy").show();
//       $('#user_skill_sets_attributes_0__destroy').prop('checked', true);
//     }
//   });
//   $("#user_skill_sets_attributes_1_skill_id").change(function() {
//     if(this.checked) {
//       $("#user_skill_sets_attributes_1__destroy").hide();
//       $('#user_skill_sets_attributes_1__destroy').prop('checked', false);
//     } else {
//       $("#user_skill_sets_attributes_1__destroy").show();
//       $('#user_skill_sets_attributes_1__destroy').prop('checked', true);
//     }
//   });
//   $("#user_skill_sets_attributes_2_skill_id").change(function() {
//     if(this.checked) {
//       $("#user_skill_sets_attributes_2__destroy").hide();
//       $('#user_skill_sets_attributes_2__destroy').prop('checked', false);
//     } else {
//       $("#user_skill_sets_attributes_2__destroy").show();
//       $('#user_skill_sets_attributes_2__destroy').prop('checked', true);
//     }
//   });
// });
