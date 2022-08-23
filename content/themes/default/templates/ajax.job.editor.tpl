<div class="modal-header">
  <h6 class="modal-title">
    <i class="fas fa-briefcase mr5"></i>{__("Edit Job")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="posts/edit.php">
  <div class="modal-body">
    <div class="row">
      <!-- job title -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("Job Title")}</label>
        <input name="title" type="text" class="form-control" value="{$post['job']['title']}">
      </div>
      <!-- job title -->
      <!-- location -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("Location")}</label>
        <input name="location" type="text" class="form-control" value="{$post['job']['location']}">
      </div>
      <!-- location -->
    </div>
    <!-- salary range -->
    <div class="form-group">
      <label class="form-control-label">{__("Salary Range")}</label>
      <div class="row">
        <div class="input-group col-md-4">
          {if $system['system_currency_dir'] == "left"}
            <div class="input-group-prepend">
              <span class="input-group-text">{$system['system_currency_symbol']}</span>
            </div>
          {/if}
          <input name="salary_minimum" type="text" class="form-control" placeholder="{__("Minimum")}" value="{$post['job']['salary_minimum']}">
          {if $system['system_currency_dir'] == "right"}
            <div class="input-group-append">
              <span class="input-group-text">{$system['system_currency_symbol']}</span>
            </div>
          {/if}
        </div>
        <div class="input-group col-md-4">
          {if $system['system_currency_dir'] == "left"}
            <div class="input-group-prepend">
              <span class="input-group-text">{$system['system_currency_symbol']}</span>
            </div>
          {/if}
          <input name="salary_maximum" type="text" class="form-control" placeholder="{__("Maximum")}" value="{$post['job']['salary_maximum']}">
          {if $system['system_currency_dir'] == "right"}
            <div class="input-group-append">
              <span class="input-group-text">{$system['system_currency_symbol']}</span>
            </div>
          {/if}
        </div>
        <div class="col-md-4">
          <select name="pay_salary_per" class="form-control">
            <option value="per_hour" {if $post['job']['pay_salary_per'] == "per_hour"}selected{/if}>{__("Per Hour")}</option>
            <option value="per_day" {if $post['job']['pay_salary_per'] == "per_day"}selected{/if}>{__("Per Day")}</option>
            <option value="per_week" {if $post['job']['pay_salary_per'] == "per_week"}selected{/if}>{__("Per Week")}</option>
            <option value="per_month" {if $post['job']['pay_salary_per'] == "per_month"}selected{/if}>{__("Per Month")}</option>
            <option value="per_year" {if $post['job']['pay_salary_per'] == "per_year"}selected{/if}>{__("Per Year")}</option>
          </select>
        </div>
      </div>
    </div>
    <!-- salary range -->
    <div class="row">
      <!-- job type -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("Job Type")}</label>
        <select name="type" class="form-control">
          <option value="full_time" {if $post['job']['type'] == "full_time"}selected{/if}>{__("Full Time")}</option>
          <option value="part_time" {if $post['job']['type'] == "part_time"}selected{/if}>{__("Part Time")}</option>
          <option value="internship" {if $post['job']['type'] == "internship"}selected{/if}>{__("Internship")}</option>
          <option value="volunteer" {if $post['job']['type'] == "volunteer"}selected{/if}>{__("Volunteer")}</option>
          <option value="contract" {if $post['job']['type'] == "contract"}selected{/if}>{__("Contract")}</option>
        </select>
      </div>
      <!-- job type -->
      <!-- category -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("Category")}</label>
        <select name="category" class="form-control">
          {foreach $jobs_categories as $category}
            {include file='__categories.recursive_options.tpl' data_category=$post['job']['category_id']}
          {/foreach}
        </select>
      </div>
      <!-- category -->
    </div>
    <!-- description -->
    <div class="form-group">
      <label class="form-control-label">{__("Description")}</label>
      <textarea name="description" rows="5" dir="auto" class="form-control">{$post['text_plain']}</textarea>
      <span class="form-text">
        {__("Describe the responsibilities and preferred skills for this job")}
      </span>
    </div>
    <!-- description -->
    <!-- custom fields -->
    {if $custom_fields['basic']}
      {include file='__custom_fields.tpl' _custom_fields=$custom_fields['basic'] _registration=false}
    {/if}
    <!-- custom fields -->
    <!-- questions -->
    <div class="form-group">
      <label class="form-control-label">{__("Questions")}</label>
      <div>
        <!-- add question -->
        {if !$post['job']['question_1_title'] || !$post['job']['question_2_title'] || !$post['job']['question_3_title']}
          <div class="add-job-question js_add-job-question"><i class="fas fa-plus-circle mr5"></i>{__("Add Question")}</div>
        {/if}
        <!-- add question -->
        <!-- question #1 -->
        <div class="job-question {if !$post['job']['question_1_title']}x-hidden{/if}" data-id="1">
          <label class="form-control-label mb10">{__("Question")} #1</label>
          <select name="question_1_type" class="form-control js_question-type">
            <option value="free_text" {if $post['job']['question_1_type'] == "free_text"}selected{/if}>{__("Free Text Question")}</option>
            <option value="yes_no_question" {if $post['job']['question_1_type'] == "yes_no_question"}selected{/if}>{__("Yes/No Question")}</option>
            <option value="multiple_choice" {if $post['job']['question_1_type'] == "multiple_choice"}selected{/if}>{__("Multiple Choice Question")}</option>
          </select>
          <span class="form-text">
            {__("Select the type of your question")}
          </span>
          <input name="question_1_title" type="text" class="form-control mt10" value="{$post['job']['question_1_title']}">
          <span class="form-text">
            {__("Ask your question")}
          </span>
          <div class="{if $post['job']['question_1_type'] != "multiple_choice"}x-hidden{/if} js_question-choices">
            <textarea name="question_1_choices" rows="3" dir="auto" class="form-control mt10">{$post['job']['question_1_choices']}</textarea>
            <span class="form-text">
              {__("One option per line")}
            </span>
          </div>
        </div>
        <!-- question #1 -->
        <!-- question #2 -->
        <div class="job-question {if !$post['job']['question_2_title']}x-hidden{/if}" data-id="2">
          <label class="form-control-label mb10">{__("Question")} #2</label>
          <select name="question_2_type" class="form-control js_question-type">
            <option value="free_text" {if $post['job']['question_2_type'] == "free_text"}selected{/if}>{__("Free Text Question")}</option>
            <option value="yes_no_question" {if $post['job']['question_2_type'] == "yes_no_question"}selected{/if}>{__("Yes/No Question")}</option>
            <option value="multiple_choice" {if $post['job']['question_2_type'] == "multiple_choice"}selected{/if}>{__("Multiple Choice Question")}</option>
          </select>
          <span class="form-text">
            {__("Select the type of your question")}
          </span>
          <input name="question_2_title" type="text" class="form-control mt10" value="{$post['job']['question_2_title']}">
          <span class="form-text">
            {__("Ask your question")}
          </span>
          <div class="{if $post['job']['question_2_type'] != "multiple_choice"}x-hidden{/if} js_question-choices">
            <textarea name="question_2_choices" rows="3" dir="auto" class="form-control mt10">{$post['job']['question_2_choices']}</textarea>
            <span class="form-text">
              {__("One option per line")}
            </span>
          </div>
        </div>
        <!-- question #2 -->
        <!-- question #3 -->
        <div class="job-question {if !$post['job']['question_3_title']}x-hidden{/if}" data-id="3">
          <label class="form-control-label mb10">{__("Question")} #3</label>
          <select name="question_3_type" class="form-control js_question-type">
            <option value="free_text" {if $post['job']['question_3_type'] == "free_text"}selected{/if}>{__("Free Text Question")}</option>
            <option value="yes_no_question" {if $post['job']['question_3_type'] == "yes_no_question"}selected{/if}>{__("Yes/No Question")}</option>
            <option value="multiple_choice" {if $post['job']['question_3_type'] == "multiple_choice"}selected{/if}>{__("Multiple Choice Question")}</option>
          </select>
          <span class="form-text">
            {__("Select the type of your question")}
          </span>
          <input name="question_3_title" type="text" class="form-control mt10" value="{$post['job']['question_3_title']}">
          <span class="form-text">
            {__("Ask your question")}
          </span>
          <div class="{if $post['job']['question_3_type'] != "multiple_choice"}x-hidden{/if} js_question-choices">
            <textarea name="question_3_choices" rows="3" dir="auto" class="form-control mt10">{$post['job']['question_3_choices']}</textarea>
            <span class="form-text">
              {__("One option per line")}
            </span>
          </div>
        </div>
        <!-- question #3 -->
      </div>
    </div>
    <!-- questions -->
    <!-- cover image -->
    <div class="form-group">
      <label class="form-control-label">{__("Cover Image")}</label>
      <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$post['job']['cover_image']}')">
        <div class="x-image-loader">
          <div class="progress x-progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
        <input type="hidden" class="js_x-image-input" name="cover_image" value="{$post['job']['cover_image']}">
      </div>
    </div>
    <!-- cover image -->
    <!-- error -->
    <div class="alert alert-danger mb0 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <input type="hidden" name="handle" value="job">
    <input type="hidden" name="id" value="{$post['post_id']}">
    <button type="button" class="btn btn-light" data-dismiss="modal">{__("Cancel")}</button>
    <button type="submit" class="btn btn-primary">{__("Save")}</button>
  </div>
</form>

<script>
  $(function() {
    /* handle job questions */
    $('.js_add-job-question').on('click', function() {
      if ($('.job-question[data-id="1"]').is(":hidden")) {
        $('.job-question[data-id="1"]').show();
        return;
      }
      if ($('.job-question[data-id="2"]').is(":hidden")) {
        $('.job-question[data-id="2"]').show();
        return;
      }
      if ($('.job-question[data-id="3"]').is(":hidden")) {
        $('.job-question[data-id="3"]').show();
        $(this).hide();
        return;
      }
    });
    /* handle job questions dependencies */
    $('.js_question-type').on('change', function() {
      if ($(this).val() == "multiple_choice") {
        $(this).parents('.job-question').find(".js_question-choices").show();
      } else {
        $(this).parents('.job-question').find(".js_question-choices").hide();
      }
    });
  });
</script>