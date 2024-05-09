{extends file='admin/admin.tpl'}
{block name=title}{if $action == "create"}{t}Add Book{/t}{else}{t}Edit Book{/t}{/if}{/block}
{block name=toolbar}
    {if $action == "edit" and isset($book)}
        <div class="heading-elements">
            <a href="{$routes->getRouteString("bookClone",["bookId"=>$book->getId()])}" class="btn btn-outline-info btn-sm btn-icon-fixed clone-this-book" target="_blank">
                <i class="fa fa-clone"></i> {t}Clone{/t}
            </a>
        </div>
    {/if}
{/block}
{block name=headerCss append}
    <link href="{$resourcePath}assets/css/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet"/>
    <link href="{$resourcePath}assets/js/plugins/summernote/summernote-bs4.css" rel="stylesheet"/>
{/block}
{block name=content}
    <div class="row">
        <div class="col-lg-8 col-xlg-9 col-md-7">
            <div class="card" id="book-block">
                {if $action == "create"}
                    {assign var=route value=$routes->getRouteString("bookCreate")}
                {elseif $action == "edit" and isset($book)}
                    {assign var=route value=$routes->getRouteString("bookEdit",["bookId"=>$book->getId()])}
                {elseif $action == "delete"}
                    {assign var=route value=""}
                {/if}
                <form action="{$route}" method="post" class="card-body book-form validate" data-edit="{if $action == "create"}false{else}true{/if}">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="name" class="control-label">{t}Title{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="title" value="{if $action == "edit"}{$book->getTitle()}{/if}">
                                <input type="hidden" name="coverId" class="coverId" value="{if $action == "edit"}{$book->getCoverId()}{/if}">
                                <input type="hidden" name="eBookId" class="eBookId" value="{if $action == "edit"}{$book->getEBookId()}{/if}">
                                <input type="hidden" name="rating" value="{if $action == "edit"}{$book->getRating()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="originalName" class="control-label">{t}Subtitle{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="subtitle" value="{if $action == "edit"}{$book->getSubtitle()}{/if}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="bookSN" class="control-label">{t}Book ID{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="bookSN" value="{if $action == "edit"}{$book->getBookSN()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="ISBN10" class="control-label">{t}ISBN 10{/t}</label>
                                <input type="text" class="form-control isbn-code-10" autocomplete="off" name="ISBN10" value="{if $action == "edit"}{$book->getISBN10()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="ISBN13" class="control-label">{t}ISBN 13{/t}</label>
                                <input type="text" class="form-control isbn-code-13" autocomplete="off" name="ISBN13" value="{if $action == "edit"}{$book->getISBN13()}{/if}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="seriesId" class="control-label">{t}Series{/t}</label>
                                <select name="seriesId" id="seriesId" class="form-control">
                                    {if $action == "edit" and $book->getSeries() != null}
                                        <option value="{$book->getSeries()->getId()}" selected>{$book->getSeries()->getName()}</option>
                                    {/if}
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="publisherId" class="control-label">{t}Publisher{/t}</label>
                                <select name="publisherId" id="publisherId" class="form-control">
                                    {if $action == "edit" and $book->getPublisher() != null}
                                        <option value="{$book->getPublisher()->getId()}" selected>{$book->getPublisher()->getName()}</option>
                                    {/if}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="authors[]" class="control-label">{t}Authors{/t}</label>
                                <select class="form-control" name="authors[]" id="authors" multiple="multiple">
                                    {if $book !== null and $book->getAuthors() !== null and is_array($book->getAuthors())}
                                        {foreach from=$book->getAuthors() item=author name=author}
                                            <option value="{$author->getId()}" selected>{$author->getLastName()} {$author->getFirstName()}</option>
                                        {/foreach}
                                    {/if}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="genres" class="control-label">{t}Genres{/t}</label>
                                <select class="form-control" name="genres[]" id="genres" multiple="multiple">
                                    {if $book !== null and $book->getGenres() !== null and is_array($book->getGenres())}
                                        {foreach from=$book->getGenres() item=genre name=genre}
                                            <option value="{$genre->getId()}" selected>{$genre->getName()}</option>
                                        {/foreach}
                                    {/if}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="edition" class="control-label">{t}Edition{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="edition" value="{if $action == "edit"}{$book->getEdition()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="publishingYear" class="control-label">{t}Published Year{/t}</label>
                                <input type="text" class="form-control year-picker" autocomplete="off" name="publishingYear" value="{if $action == "edit"}{$book->getPublishingYear()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="pages" class="control-label">{t}Pages{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="pages" value="{if $action == "edit"}{$book->getPages()}{/if}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="type" class="control-label">{t}Type{/t}</label>
                                {if isset($bookTypes) and $bookTypes !== null}
                                    <select name="type" class="form-control select-picker">
                                        {foreach from=$bookTypes item=type name=type}
                                            <option value="{$type->getName()}"{if $action == "edit" and $book->getType() == $type->getName()} selected{/if}>{$type->getName()}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="physicalForm" class="control-label">{t}Physical Form{/t}</label>
                                {if isset($physicalForms) and $physicalForms !== null}
                                    <select name="physicalForm" class="form-control select-picker">
                                        {foreach from=$physicalForms item=form name=form}
                                            <option value="{$form->getName()}"{if $action == "edit" and $book->getPhysicalForm() == $form->getName()} selected{/if}>{$form->getName()}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="size" class="control-label">{t}Size{/t}</label>
                                {if isset($bookSizes) and $bookSizes !== null}
                                    <select name="size" class="form-control select-picker">
                                        {foreach from=$bookSizes item=size name=size}
                                            <option value="{$size->getName()}"{if $action == "edit" and $book->getSize() == $size->getName()} selected{/if}>{$size->getName()}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="binding" class="control-label">{t}Binding{/t}</label>
                                {if isset($bindings) and $bindings !== null}
                                    <select name="binding" id="bindingId" class="form-control select-picker">
                                        {foreach from=$bindings item=binding name=binding}
                                            <option value="{$binding->getName()}"{if $action == "edit" and $book->getBinding() == $binding->getName()} selected{/if}>{$binding->getName()}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group eBook-upload">
                                <label for="eBook" class="control-label eBook-link">
                                    {if $action == "edit" and $book->getEBookId() != null}
                                        <a href="{$routes->getRouteString("electronicBookGet",["electronicBookId"=>$book->getEBookId()])}">{t}eBook{/t}</a>{else}{t}eBook{/t}{/if}
                                </label>
                                <div class="fileinput {if $action == "edit" and $book->getEBookId() != null}fileinput-exists{else}fileinput-new{/if} input-group" data-provides="fileinput">
                                    <div class="form-control" data-trigger="fileinput">
                                        <i class="glyphicon glyphicon-file fileinput-exists"></i>
                                        <span class="fileinput-filename">{if $action == "edit" and $book->getEBook() != null}{basename($book->getEBook()->getWebPath())}{/if}</span>
                                    </div>
                                    <span class="input-group-addon bg-white btn btn-default btn-file">
                                        <span class="fileinput-new">{t}Select eBook{/t}</span>
                                        <span class="fileinput-exists">{t}Change eBook{/t}</span>
                                        <input type="file" name="file" value="{if $action == "edit"}{if $book->getEBookId() != null}{$book->getEBookId()}{/if}{/if}" class="disabledIt">
                                    </span>
                                    <a href="#" class="input-group-addon bg-white btn btn-default delete-eBook fileinput-exists" data-id="{if $action == "edit" and isset($book)}{$book->getEBookId()}{/if}" data-dismiss="fileinput">{t}Remove{/t}</a>
                                    <a href="#" class="input-group-addon bg-white btn btn-default uploadEBook fileinput-exists">
                                        <i class="fa fa-upload mr-1"></i> {t}Upload{/t}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="stores" class="control-label">{t}Store{/t}</label>
                                <select class="form-control" name="stores[]" id="stores" multiple="multiple">
                                    {if $book !== null and $book->getStores() !== null and is_array($book->getStores())}
                                        {foreach from=$book->getStores() item=store name=store}
                                            <option value="{$store->getId()}" selected>{$store->getName()}</option>
                                        {/foreach}
                                    {/if}
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="locations" class="control-label">{t}Location{/t}</label>
                                <select class="form-control" name="locations[]" id="locations" multiple="multiple">
                                    {if $book !== null and $book->getLocations() !== null and is_array($book->getLocations())}
                                        {foreach from=$book->getLocations() item=location name=location}
                                            <option value="{$location->getId()}" selected>{$location->getName()} [{$location->getStore()->getName()}]</option>
                                        {/foreach}
                                    {/if}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="quantity" class="control-label">{t}Quantity{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="quantity" value="{if $action == "edit"}{$book->getQuantity()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="price" class="control-label">{t}Price{/t} </label>
                                <span>({$siteViewOptions->getOptionValue("priceCurrency")})</span>
                                <input type="text" class="form-control" autocomplete="off" name="price" value="{if $action == "edit"}{$book->getPrice()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="language" class="control-label">{t}Language{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="language" value="{if $action == "edit"}{$book->getLanguage()}{/if}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="description" class="control-label">{t}Description{/t}</label>
                                <textarea type="text" class="form-control" autocomplete="off" name="description" id="content-box">{if $action == "edit"}{$book->getDescription()}{/if}</textarea>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="notes" class="control-label">{t}Notes{/t}</label>
                                <textarea type="text" class="form-control" autocomplete="off" name="notes">{if $action == "edit"}{$book->getNotes()}{/if}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="shortDescription">{t}Meta Title{/t}</label>
                                <input type="text" name="metaTitle" class="form-control" value="{*if $action == "edit"}{$post->getMetaTitle()}{/if*}">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="shortDescription">{t}Meta Keywords{/t}</label>
                                <select name="metaKeySelect" id="meta-key" class="form-control" multiple>
                                    {if $action == "edit"}
                                        {assign var="tagList" value=","|explode:$book->getMetaKeywords()}
                                        {foreach from=$tagList item=tag}
                                            {if $tag != null}
                                                <option value="{$tag}" selected>{$tag}</option>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                </select>
                                <input type="hidden" name="metaKeywords" id="metaKeyList" value="{if $action == "edit"}{$book->getMetaKeywords()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="shortDescription">{t}Meta Description{/t}</label>
                                <textarea name="metaDescription" cols="30" rows="2" style="width:100% !important" class="form-control">{if $action == "edit"}{$book->getMetaDescription()}{/if}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <button type="submit" class="btn btn-outline-secondary disabled pull-right save-book">
                                    <i class="fa fa-floppy-o"></i> {t}Save{/t}
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-lg-4 col-xlg-3 col-md-5">
            <div class="card" id="cover-block">
                <div class="card-body main-image-upload">
                    <div class="fileinput {if $action == "edit" and $book->getCoverId() != null}fileinput-exists{else}fileinput-new{/if}" style="width: 100%;" data-provides="fileinput">
                        <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 100%; min-height: 150px;">
                            {if $action == "edit" and $book->getCover() != null}
                                <img src="{$book->getCover()->getWebPath()}" alt="" class="img-fluid">
                            {else}
                                <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="" class="img-fluid">
                            {/if}
                        </div>
                        <div>
                            <a href="#" class="btn btn-sm btn-outline-secondary fileinput-exists delete-main-img" data-id="{if $action == "edit" and isset($book)}{$book->getCoverId()}{/if}" data-dismiss="fileinput">{t}Remove{/t}</a>
                            <span class="btn btn-sm btn-outline-secondary btn-file file-input">
                                <span class="fileinput-new">{t}Select image{/t}</span>
                                <span class="fileinput-exists">{t}Change{/t}</span>
                                <input type="file" name="file" value="{if $action == "edit"}{if $book->getCoverId() != null}{$book->getCoverId()}{/if}{/if}" class="disabledIt">
                            </span>
                            <a href="#" class="btn btn-sm btn-outline-secondary uploadCover fileinput-exists">
                                <i class="fa fa-upload"></i> {t}Upload{/t}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerPageJs append}
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/select2/select2.full.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jasnyupload/fileinput.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jquery-validate/jquery.validate.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-select/bootstrap-select.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/summernote/summernote-bs4.min.js"></script>
{/block}
{block name=footerCustomJs append}
    <script>
        $(document).ready(function () {
            $('#content-box').summernote().on('summernote.change', function () {
                $('.book-form').attr('data-changed', true);
                $('.save-book').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            $('.year-picker').datepicker({
                format: "yyyy",
                startView: 2,
                minViewMode: 2,
                maxViewMode: 2,
                keepOpen: true
            });
            $('.isbn-code-10, .isbn-code-13').on('change', function () {
                onlyDigits($(this));
            });
            var genreSearchUrl = '{$routes->getRouteString("genreSearchPublic",[])}';
            $("#genres").select2({
                ajax: {
                    url: genreSearchUrl,
                    dataType: 'json',
                    type: 'POST',
                    data: function (params) {
                        return {
                            searchText: params.term
                        };
                    },
                    processResults: function (data, params) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                return {
                                    results: $.map(data, function (item) {
                                        return {
                                            text: item.name,
                                            id: item.id,
                                            term: params.term
                                        }
                                    })
                                };
                            }
                        }
                    },
                    cache: false
                },
                templateResult: function (item) {
                    if (item.loading) {
                        return item.text;
                    }
                    return app.markMatch(item.text, item.term);
                },
                minimumInputLength: 2
            });
            var storeSearchUrl = '{$routes->getRouteString("storeSearchPublic",[])}';
            $("#stores").select2({
                ajax: {
                    url: storeSearchUrl,
                    dataType: 'json',
                    type: 'POST',
                    data: function (params) {
                        return {
                            searchText: params.term
                        };
                    },
                    processResults: function (data, params) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                return {
                                    results: $.map(data, function (item) {
                                        return {
                                            text: item.name,
                                            id: item.id,
                                            term: params.term
                                        }
                                    })
                                };
                            }
                        }
                    },
                    cache: false
                },
                templateResult: function (item) {
                    if (item.loading) {
                        return item.text;
                    }
                    return app.markMatch(item.text, item.term);
                },
                minimumInputLength: 2
            });
            var locationSearchUrl = '{$routes->getRouteString("locationSearchPublic",[])}';
            $("#locations").select2({
                ajax: {
                    url: locationSearchUrl,
                    dataType: 'json',
                    type: 'POST',
                    data: function (params) {
                        var datas = $("#stores").serialize() + '&searchText=' + params.term;
                        return datas;
                    },
                    processResults: function (data, params) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                return {
                                    results: $.map(data, function (item) {
                                        return {
                                            text: item.name + ' (' + item.store.name + ')',
                                            id: item.id,
                                            term: params.term
                                        }
                                    })
                                };
                            }
                        }
                    },
                    cache: false
                },
                templateResult: function (item) {
                    if (item.loading) {
                        return item.text;
                    }
                    return app.markMatch(item.text, item.term);
                },
                minimumInputLength: 2
            });
            var authorSearchUrl = '{$routes->getRouteString("authorSearchPublic",[])}';
            $("#authors").select2({
                ajax: {
                    url: authorSearchUrl,
                    dataType: 'json',
                    type: 'POST',
                    data: function (params) {
                        return {
                            searchText: params.term
                        };
                    },
                    processResults: function (data, params) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                return {
                                    results: $.map(data, function (item) {
                                        if (item.firstName) {
                                            var text = item.firstName + ' ' + item.lastName;
                                        } else {
                                            text = item.lastName;
                                        }
                                        return {
                                            text: text,
                                            id: item.id,
                                            term: params.term
                                        }
                                    })
                                };
                            }
                        }
                    },
                    cache: false
                },
                templateResult: function (item) {
                    if (item.loading) {
                        return item.text;
                    }
                    return app.markMatch(item.text, item.term);
                },
                minimumInputLength: 2
            });
            var publisherSearchUrl = '{$routes->getRouteString("publisherSearchPublic",[])}';
            $('#publisherId').select2({
                ajax: {
                    url: function () {
                        return publisherSearchUrl;
                    },
                    dataType: 'json',
                    type: 'POST',
                    data: function (params) {
                        return {
                            searchText: params.term
                        };
                    },
                    processResults: function (data, params) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                return {
                                    results: $.map(data, function (item) {
                                        return {
                                            text: item.name,
                                            id: item.id,
                                            term: params.term
                                        }
                                    })
                                };
                            }
                        }
                    },
                    cache: true
                },
                templateResult: function (item) {
                    if (item.loading) {
                        return item.text;
                    }
                    return app.markMatch(item.text, item.term);
                },
                minimumInputLength: 2
            });
            var seriesSearchUrl = '{$routes->getRouteString("seriesSearchPublic",[])}';
            $('#seriesId').select2({
                ajax: {
                    url: function () {
                        return seriesSearchUrl;
                    },
                    dataType: 'json',
                    type: 'POST',
                    data: function (params) {
                        return {
                            searchText: params.term
                        };
                    },
                    processResults: function (data, params) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                return {
                                    results: $.map(data, function (item) {
                                        return {
                                            text: item.name,
                                            id: item.id,
                                            term: params.term
                                        }
                                    })
                                };
                            }
                        }
                    },
                    cache: true
                },
                templateResult: function (item) {
                    if (item.loading) {
                        return item.text;
                    }
                    return app.markMatch(item.text, item.term);
                },
                minimumInputLength: 2
            });
            $('.validate input,.validate select,.validate textarea').tooltipster({
                trigger: 'custom',
                onlyOne: false,
                position: 'bottom',
                offsetY: -5,
                theme: 'tooltipster-kaa'
            });
            $('.validate').validate({
                errorPlacement: function (error, element) {
                    if (element != undefined) {
                        $(element).tooltipster('update', $(error).text());
                        $(element).tooltipster('show');
                    }
                },
                success: function (label, element) {
                    $(element).tooltipster('hide');
                },
                rules: {
                    title: {
                        required: true
                    },
                    pages: {
                        number: true
                    },
                    price: {
                        number: true
                    },
                    quantity: {
                        number: true
                    },
                    publishingYear: {
                        number: true
                    },
                    ISBN10: {
                        digits: true,
                        maxlength: 10,
                        minlength: 10
                    },
                    ISBN13: {
                        digits: true,
                        maxlength: 13,
                        minlength: 13
                    }
                }
            });
            $('#meta-key').select2({
                multiple: true,
                tags: true,
                allowClear: true,
                language: {
                    noResults: function () {
                        return "{t}Please enter keywords{/t}";
                    }
                }
            }).on('change.select2', function () {
                $("#metaKeyList").val($(this).val());
            });
            $(document).on('change ifChanged', 'input,textarea,select', function () {
                $(this).closest('form').attr('data-changed', true);
                $('.save-book').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            $(document).on('click', '.close', function () {
                $(this).closest('.fileinput').find('input:file').removeClass('file-exists');
            });
            var eBookUploadUrl = '{$routes->getRouteString("electronicBookUpload",[])}';
            var eBookGetUrl = '{$routes->getRouteString("electronicBookGet",[])}';
            $('.uploadEBook').on('click', function (e) {
                e.preventDefault();
                var rowData, fileValue, file;

                var dataChanged = $('.eBook-upload .fileinput').attr('data-changed');
                var imageUploadElement = $('.eBook-upload');

                if (dataChanged == 'true') {
                    rowData = new FormData();
                    file = $(imageUploadElement).find('input:file');
                    fileValue = $(imageUploadElement).find('input:file').val();
                    var eBookId = $('.eBookId').val();
                    if ($(file)[0].files[0] != null) {
                        rowData.append('file', $(file)[0].files[0], fileValue);
                        if (eBookId) {
                            rowData.append('eBookId', eBookId);
                        }
                    } else if ($(file).closest('.fileinput').hasClass('fileinput-new')) {
                        rowData.append('file', null);
                        if (eBookId) {
                            rowData.append('eBookId', eBookId);
                        }
                    } else {
                        rowData.append('file', '');
                        if (eBookId) {
                            rowData.append('eBookId', eBookId);
                        }
                    }
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        processData: false,
                        contentType: false,
                        data: rowData,
                        url: eBookUploadUrl,
                        beforeSend: function (data) {
                            app.card.loading.start('#book-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.delete-eBook').attr('data-id', data.eBookId);
                                    $('.eBookId').val(data.eBookId);
                                    if ($('.eBook-link a').length > 0) {
                                        $('.eBook-link a').attr('href', eBookGetUrl.replace('[electronicBookId]', data.eBookId));
                                    } else {
                                        $('.eBook-link').html('<a href="' + eBookGetUrl.replace('[electronicBookId]', data.eBookId) + '">{t}eBook{/t}</a>')
                                    }
                                    $('.save-book').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#book-block');
                        }
                    });
                }
            });
            var eBookDeleteUrl = '{$routes->getRouteString("electronicBookDelete",[])}';
            $(document).on('clear.bs.fileinput', '.eBook-upload .fileinput', function () {
                var eBookId = $(this).find('.delete-eBook').attr('data-id');
                if (eBookId != undefined && eBookId != null && eBookId > 0) {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        url: eBookDeleteUrl.replace("[electronicBookId]", eBookId),
                        beforeSend: function (data) {
                            app.card.loading.start('#book-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.eBookId').val('');
                                    $('.eBook-link').text('{t}eBook{/t}');
                                    $('.save-book').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#book-block');
                        }
                    });
                }
            });

            var imageDeleteUrl = '{$routes->getRouteString("imageDelete",[])}';
            $(document).on('clear.bs.fileinput', '.main-image-upload .fileinput', function () {
                var imgId = $(this).find('.delete-main-img').attr('data-id');
                if (imgId != undefined && imgId != null && imgId > 0) {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        url: imageDeleteUrl.replace("[imageId]", imgId),
                        beforeSend: function (data) {
                            app.card.loading.start('#cover-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.coverId').val('');
                                    $('.save-book').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#cover-block');
                        }
                    });
                }
            });
            $(document).on('change.bs.fileinput', '.main-image-upload .fileinput, .gallery-image-upload .fileinput, .eBook-upload .fileinput', function () {
                $(this).attr('data-changed', true);
                $('.book-form').attr('data-changed', true);
                $('.save-book').removeClass('btn-default disabled').addClass('btn-success');
                $(this).find('input:file').addClass('file-exists');
            });
            var coverUploadUrl = '{$routes->getRouteString("coverUpload",[])}';
            $('.uploadCover').on('click', function (e) {
                e.preventDefault();
                var rowData, fileValue, file;

                var dataChanged = $('.main-image-upload .fileinput').attr('data-changed');
                var imageUploadElement = $('.main-image-upload');

                if (dataChanged == 'true') {
                    rowData = new FormData();
                    file = $(imageUploadElement).find('input:file');
                    fileValue = $(imageUploadElement).find('input:file').val();
                    var coverId = $('.coverId').val();
                    if ($(file)[0].files[0] != null) {
                        rowData.append('file', $(file)[0].files[0], fileValue);
                        if (coverId) {
                            rowData.append('coverId', coverId);
                        }
                    } else if ($(file).closest('.fileinput').hasClass('fileinput-new')) {
                        rowData.append('file', null);
                        if (coverId) {
                            rowData.append('coverId', coverId);
                        }
                    } else {
                        rowData.append('file', '');
                        if (coverId) {
                            rowData.append('coverId', coverId);
                        }
                    }
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        processData: false,
                        contentType: false,
                        data: rowData,
                        url: coverUploadUrl,
                        beforeSend: function (data) {
                            app.card.loading.start('#cover-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.delete-main-img').attr('data-id', data.imageId);
                                    $('.coverId').val(data.imageId);
                                    $('.save-book').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#cover-block');
                        }
                    });
                }
            });
            function onlyDigits(e) {
                var value = $(e).val().replace(/\D/g, '');
                return $(e).val(value);
            }

            var bookEditUrl = '{$routes->getRouteString("bookEdit",[])}';
            var cloneBookUrl = '{$routes->getRouteString("bookClone",[])}';
            $('.save-book').on('click', function (e) {
                e.preventDefault();
                var form = $(this).closest('form');
                var dataEdit = form.attr('data-edit');
                var dataChanged = form.attr('data-changed');
                if (dataChanged == 'true') {
                    if ($(form).valid()) {
                        $.ajax({
                            dataType: 'json',
                            method: 'POST',
                            data: form.serialize(),
                            url: form.attr('action'),
                            beforeSend: function (data) {
                                app.card.loading.start('.card');
                            },
                            success: function (data) {
                                if (data.redirect) {
                                    window.location.href = data.redirect;
                                } else {
                                    if (data.error) {
                                        app.notification('error', data.error);
                                    } else {
                                        form.attr('action', bookEditUrl.replace("[bookId]", data.bookId)).attr('data-changed', false);
                                        $('.clone-this-book').attr('href', cloneBookUrl.replace("[bookId]", data.bookId));
                                        app.notification('success', '{t}Data has been saved successfully{/t}');
                                        $('.save-book').removeClass('btn-success').addClass('btn-default disabled');
                                        if (dataEdit == 'false') {
                                            $('.page-title h3').text('{t}Edit Book{/t}');
                                            history.pushState(null, '', bookEditUrl.replace("[bookId]", data.bookId));
                                        }
                                        $('.book-form').attr('data-edit', true);
                                    }
                                }
                            },
                            error: function (jqXHR, exception) {
                                app.notification('error', app.getErrorMessage(jqXHR, exception));
                            },
                            complete: function (data) {
                                app.card.loading.finish('.card');
                            }
                        });
                    } else {
                        app.notification('information', '{t}Validation errors occurred. Please confirm the fields and submit it again.{/t}');
                    }
                } else {
                    app.notification('information', '{t}Nothing to save.{/t}');
                }
            });
        });
    </script>
{/block}